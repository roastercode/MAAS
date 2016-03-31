#!/bin/bash
# VirusScan & report log
# Multiplexer Administrator Solution
# License: GPL v2 or later
# Author: Aurelien DESBRIERES - aurelien@hackers.camp
# VirusScan is part of MAS
# https://github.com/aurelien-git/MAS

tput clear # clear the terminal

printf "\033[1;32mWelcome to FARON - Forensic Analyser Remote Over Network\033[0m%s\n"
printf "\033[1;32mFARON is made to run as a MAS dependencie\033[0m%s\n"
printf "\033[1;32mFARON will run during more than one hour!\033[0m%s\n"


# Register the user identification during process
printf "\033[1;32m%s\nRegistering you identification during the MAS process\033[0m%s\n"
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval "$(ssh-agent)"
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add



# Vefify and install the dependencies if needed
printf "%s\nThe software will now get the needed dependencies for your\noperating system $the_user%s\n"  

command_exists () {
    type "$1" &> /dev/null ;
}

# For Debian / Ubuntu / Trisquel / gNewSense and derivatives
if command_exists apt-get ; then
    sudo apt-get install clamav clamav-update clamav-freshclam clamdscan gawk
fi

# For Archlinux / Parabola and derivatives
if command_exists pacman ; then
    sudo pacman -Sy clamav clamav-update iw
fi

# For Android / Cyanogen / Replicant and derivatives
if command_exists apt ; then
    sudo apt install clamav clamav-update
fi

# For RedHat / Fedora / Centos and derivatives
if command_exists dnf ; then
    sudo dnf install clamav clamav-update gawk
fi
#    command_exists yum ; then
#    sudo yum install clamav clamav-update gawk
#fi


# command
the_user="$(whoami)"
#the_machine="$(hostname)"
#network="$(ip addr show | awk '/inet.*brd/{print $NF; exit}')"
#ip_only="$(ip addr show $network | grep 'inet\b' | awk '{print $2}' | cut -d/ -f1)"
ip_only="$(awk -F'[ /]+'  '/inet /{print $3}')"
firewall="$(sudo iptables -L)"
virusscan="$(sudo freshclam && sudo clamscan -ri --log=clam-log --cross-fs=yes /)"
sudo mkdir -p MAS-REPORT

## Virus analysis
### scan all type of filesystem

touch MAS-REPORT/faron-report-"$ip_only"-virus || exit
truncate -s 0 MAS-REPORT/faron-report-"$ip_only"-virus

printf "%s\n\033[1;32mYour firewall rules are:\033[0m\n$firewall%s\n" | tee -a MAS-REPORT/faron-report-"$ip_only"-virus

# request what the admin want
printf "%s\n\033[1;32mScanning against virus will take more than one hour\033[0m%s\n"
"$virusscan"
printf "\033[1;32mResult of the virus scan:\033[0m\n$virusscan%s\n" | tee -a MAS-REPORT/faron-report-"$ip_only"-virus
t

## Bring back all log to the admin
mkdir -p ~/MAS-REPORT/LOG/
sudo tar czvf mas-virus-log"$ip_only".tar.gz ~/MAS-REPORT/LOG/

