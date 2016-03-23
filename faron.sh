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
printf "\nThe software will now get the needed dependencies for your\noperating system $the_user\n"  

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
the_user=`whoami`
the_machine=`hostname`
ip=`ip a | grep inet | grep 192`
network=`ip addr show | awk '/inet.*brd/{print $NF; exit}'`


# Network Analysis
## Network Interface Analysis
### print hostname of the current machine
printf "\n\033[1;32mYour hostname is:\033[0m $the_machine\n" | tee -a /home/$the_user/MAS-REPORT/faron-report-$the_user-hostname
### print IP of the machine
printf "\033[1;32mYour IP is:\033[0m $ip\n" | tee -a /home/$the_user/MAS-REPORT/faron-report-$the_user-IP
### Searching name of the active interface
printf "\033[1;32mHere is your network interface:\033[0m $network\n\n"
### search available network arround
printf "\n\033[1;32mFARON will now look for available network around you (if you use wifi)\033[0m\n"
printf "\033[1;32mHere is the list of available network arround you $the_user\033[0m\n"
sudo iw $network scan | awk -f scan.awk | tee -a /home/$the_user/MAS-REPORT/faron-report-network-list
### catching wifi network arround
printf "\n\033[1;32mFARON will not get closer informations on networks\n(also if there is wifi network around you.)\033[0m\n"
printf "\033[1;32mCloser information on that wifi network around:\033[0m\n"
sudo iwlist $network s | grep 'ESSID\|IEEE' | tee -a /home/$the_user/MAS-REPORT/faron-report-network-arround-$the_user

## Network Traffic Analysis
### scan active connection
printf "\n\033[1;32mscanning active Internet connections from $the_user\033[0m\n"
sudo netstat -natpe | tee -a /home/$the_user/MAS-REPORT/faron-report-$the_user-active-Internet-connections
### print neighborwood
printf "\n\033[1;32mThere is different machine in your network:\033[0m\n"
ip neighbor | tee -a /home/$the_user/MAS-REPORT/faron-report-$the_user-neighborwood
### Load traffic analysis
printf "\n\033[1;32mAnalysing now your traffic that will take 5 minutes\033[0m\n"
printf "\033[1;32mLoading traffic analysis:\033[0m\n"
sudo iftop -i $network -ts 300 | tee -a /home/$the_user/MAS-REPORT/faron-report-traffic-analysis # 300 number of second of analysis


# Settings and Hardware Analysis
## Firewall analysis
### print firewall rules
firewall=`sudo iptables -L`
printf "\n\033[1;32mYour firewall rules are:\033[0m\n$firewall\n" | tee -a /home/$the_user/MAS-REPORT/faron-report-$the_user-firewall

## Virus analysis
### scan all type of filesystem
printf "\n\033[1;32mScanning against virus will take more than one hour\033[0m\n"
virusscan=`sudo freshclam && sudo clamscan -ri --log=clam-log --cross-fs=yes /`
printf "\033[1;32mResult of the virus scan:\033[0m\n$virusscan\n" | tee -a /home/$the_user/MAS-REPORT/faron-report-$the_user-virus

## Log analysis
### list all log of the machin
printf "\n\033[1;32mList of all your log on $hostname:\033[0m\n"
sudo ls -lait /var/log/ | tee -a /home/$the_user/MAS-REPORT/faron-report-log-list-of-$the_machine

## Bring back all log to the admin
mkdir ~/MAS-REPORT/LOG/
mussh -a -i /home/$the_user/.ssh/$private -d -H mas-hostfile -c "scp -r MAS-REPORT/* $the_user@hostname  -I | cut -f1 -d' ':~/MAS-REPORT/LOG/" -m2
