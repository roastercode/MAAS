#!/bin/bash
# FARON
# Forensic Analyser Remote Over Network
# License: GPL v2 or later
# Author: Aurelien DESBRIERES - aurelien@hackers.camp
# FARON is part of MAS
# https://github.com/aurelien-git/MAS

tput clear # clear the terminal

printf "\n\033[1;32mWelcome to FARON - Forensic Analyser Remote Over Network\033[0m\n"
printf "\033[1;32mFARON is made to run as a MAS dependencie\033[0m\n"
printf "\033[1;32mFARON will run during more than one hour!\033[0m\n"

# Vefify and install the dependencies if needed
printf "%s\nThe software will now get the needed dependencies for your%s\noperating system $the_user%s\n"  

# command
the_user="$(whoami)"
the_machine="$(hostname)"
ip="$(ip a | grep inet | grep 192)"
network="$(ip addr show | awk '/inet.*brd/{print $NF; exit}')"
ip_only="$(ip addr show "$network" | grep 'inet\b' | grep 192 | awk '{print $2}' | cut -d/ -f1)"
firewall="$(sudo iptables -L)"

# Register the user identification during process
printf "\033[1;32m%s\nRegistering you identification during the MAS process\033[0m%s\n"
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval "$(ssh-agent)"
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add


command_exists () {
    type "$1" &> /dev/null ;
}

# For Debian / Ubuntu / Trisquel / gNewSense and derivatives
if command_exists apt-get ; then
    sudo apt-get install gawk
fi

# For Archlinux / Parabola and derivatives
if command_exists pacman ; then
    sudo pacman -Sy iw gawk
fi

# For Android / Cyanogen / Replicant and derivatives
if command_exists apt ; then
    sudo apt install gawk
fi

# For RedHat / Fedora / Centos and derivatives
if command_exists dnf ; then
    sudo dnf install gawk
fi


sudo mkdir MAS-REPORT

# Network Analysis
## Network Interface Analysis
### print hostname of the current machine
touch MAS-REPORT/faron-report-"$ip_only"-hostname || exit
truncate -s 0 MAS-REPORT/faron-report-"$ip_only"-hostname

printf "%s\n\033[1;32mYour hostname is:\033[0m $the_machine%s\n" | tee -a MAS-REPORT/faron-report-"$ip_only"-hostname


### print IP of the machine
touch MAS-REPORT/faron-report-"$ip_only-IP" || exit
truncate -s 0 MAS-REPORT/faron-report-"$ip_only-IP"

printf "\033[1;32mYour IP is:\033[0m $ip%s\n" | tee -a MAS-REPORT/faron-report-"$ip_only"-IP


### Searching name of the active interface
printf "\033[1;32mHere is your network interface:\033[0m $network%s\n%s\n"


### search available network arround
touch MAS-REPORT/faron-report-network-list-"$ip_only" || exit
truncate -s 0 MAS-REPORT/faron-report-network-list-"$ip_only"

printf "%s\n\033[1;32mFARON will now look for available network around you (if you use wifi)\033[0m%s\n"
printf "\033[1;32mHere is the list of available network arround you $the_user\033[0m%s\n"
sudo iw "$network" scan | awk -f /root/MAS/scan.awk | tee -a MAS-REPORT/faron-report-network-list-"$ip_only"


### catching wifi network arround
touch MAS-REPORT/faron-report-network-arround-"$ip_only" || exit
truncate -s 0 MAS-REPORT/faron-report-network-arround-"$ip_only"


printf "%s\n\033[1;32mFARON will now get closer informations on networks%s\n(also if there is wifi network around you.)\033[0m%s\n"
printf "\033[1;32mCloser information on that wifi network around:\033[0m%s\n"
sudo iwlist "$network" s | grep 'ESSID\|IEEE' | tee -a MAS-REPORT/faron-report-network-arround-"$the_user"


## Network Traffic Analysis
### scan active connection

touch MAS-REPORT/faron-report-"$ip_only"-active-Internet-connections || exit
truncate -s 0 MAS-REPORT/faron-report-"$ip_only"-active-Internet-connections


printf "%s\n\033[1;32mscanning active Internet connections from $the_user\033[0m%s\n"
sudo netstat -natpe | tee -a MAS-REPORT/faron-report-"$ip_only"-active-Internet-connections


### print neighborwood
touch MAS-REPORT/faron-report-"$ip_only"-neighborwood || exit
truncate -s 0 MAS-REPORT/faron-report-"$ip_only"-neighborwood


printf "%s\n\033[1;32mThere is different machine in your network:\033[0m%s\n"
ip neighbor | tee -a MAS-REPORT/faron-report-"$ip_only"-neighborwood


### Load traffic analysis
touch MAS-REPORT/faron-report-traffic-analysis-"$ip_only" || exit
truncate -s 0 MAS-REPORT/faron-report-traffic-analysis-"$ip_only"

printf "%s\n\033[1;32mAnalysing now your traffic that will take 5 minutes\033[0m%s\n"
printf "\033[1;32mLoading traffic analysis:\033[0m%s\n"
sudo iftop -i "$network" -ts 300 | tee -a MAS-REPORT/faron-report-traffic-analysis-"$ip_only" # 300 number of second of analysis


# Settings and Hardware Analysis
## Firewall analysis
### print firewall rules
touch MAS-REPORT/faron-report-"$ip_only"-firewall || exit
truncate -s 0 MAS-REPORT/faron-report-"$ip_only"-firewall

printf "%s\n\033[1;32mYour firewall rules are:\033[0m%s\n$firewall%s\n" | tee -a MAS-REPORT/faron-report-"$ip_only"-firewall


## Log analysis
### list all log of the machine
touch MAS-REPORT/faron-report-log-list-of-"$the_machine" || exit
truncate -s 0 MAS-REPORT/faron-report-log-list-of-$"$the_machine"

printf "%s\n\033[1;32mList of all your log on $the_machine:\033[0m%s\n"
sudo ls -lait /var/log/ | tee -a MAS-REPORT/faron-report-log-list-of-"$the_machine"

## Bring back all log to the admin
### log of FARON + log of the machine
sudo tar czvf log"$ip_only".tar.gz /var/log/
sudo mkdir -p ~/MAS-REPORT/LOG/
cp log"$ip_only".tar.gz ~/MAS-REPORT/LOG/
sudo tar czvf mas-log"$ip_only".tar.gz ~/MAS-REPORT/
