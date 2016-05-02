#!/bin/bash
# SYSINFO
# System Information Analyser Remote Over Network

# Copyright (C) 2016 Aurélien DESBRIÈRES <aurelien@hackers.camp> 

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# SYSINFO is part of MAAS
# https://github.com/aurelien-git/MAAS
# Bring back system information from remote machines

tput clear # clear the terminal

printf "\n\033[1;32mWelcome to SYSINFO - SYSTEM INFORMATION\033[0m\n"
printf "\033[1;32mSYSINFO is made to run as a MAAS dependencie\033[0m\n"

# Vefify and install the dependencies if needed
printf "%s\nThe software will now get the needed dependencies for your%s\noperating system $t\
he_user%s\n"

# command
the_user="$(whoami)"
the_machine="$(hostname)"
ip="$(ip a | grep inet | grep 192)"
network="$(ip addr show | awk '/inet.*brd/{print $NF; exit}')"
ip_only="$(ip addr show "$network" | grep 'inet\b' | grep 192 | awk '{print $2}' | cut -d/ -f\
1)"
firewall="$(sudo iptables -L)"

# Register the user identification during process
printf "\033[1;32m%s\nRegistering you identification during the MAAS process\033[0m%s\n"
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval "$(ssh-agent)"
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add

# sysinfo request the need to install dependencies on remote target
# dependencies
command_exists () {
    type "$1" &> /dev/null ;
}

# For Debian / Ubuntu / Trisquel / gNewSense and derivatives
if command_exists apt-get ; then
    sudo apt-get install gawk df nethogs sysstat lshw lsscsi hdparm dmidecode
fi

# For Archlinux / Parabola and derivatives
if command_exists pacman ; then
    sudo pacman -Sy iw gawk df nethogs sysstat lshw lsscsi hdparm dmidecode
fi

# For Android / Cyanogen / Replicant and derivatives
if command_exists apt ; then
    sudo apt install gawk df nethogs sysstat lshw lsscsi hdparm dmidecode
fi

# For RedHat / Fedora / Centos and derivatives
if command_exists dnf ; then
    sudo dnf install gawk df nethogs sysstat lshw lsscsi hdparm dmidecode
else
    sudo yum install gawk df nethogs sysstat lshw lsscsi hdparm dmidecode
fi

sudo mkdir MAAS-REPORT

# Load the analysis
### Print Harddrive informations
touch MAAS-REPORT/sysinfo-report-"$ip_only"-harddrive || exit
truncate -s 0 MAAS-REPORT/sysinfo-report-"$ip_only"-harddrive

printf "%s\n\033[1;32mHere is the information of the Harddrive:\033[0m%s\n"
df -h | tee -a MAAS-REPORT/sysinfo-report-"$ip_only"-harddrive
sudo lshw -short | tee -a MAAS-REPORT/sysinfo-report-"$ip_only"-harddrive
lsblk | tee -a MAAS-REPORT/sysinfo-report-"$ip_only"-harddrive
lsusb | tee -a MAAS-REPORT/sysinfo-report-"$ip_only"-harddrive
lspci | tee -a MAAS-REPORT/sysinfo-report-"$ip_only"-harddrive
lsscsi -s | tee -a MAAS-REPORT/sysinfo-report-"$ip_only"-harddrive
sudo fdisk -l | tee -a MAAS-REPORT/sysinfo-report-"$ip_only"-harddrive
sudo dmidecode -t memory | tee -a MAAS-REPORT/sysinfo-report-"$ip_only"-harddrive
sudo dmidecode -t processor | tee -a MAAS-REPORT/sysinfo-report-"$ip_only"-harddrive
sudo dmidecode -t system | tee -a MAAS-REPORT/sysinfo-report-"$ip_only"-harddrive
sudo dmidecode -t bios | tee -a MAAS-REPORT/sysinfo-report-"$ip_only"-harddrive

### Program Communication on Network analysis
touch MAAS-REPORT/sysinfo-report-"$ip_only"-program_analysis || exit
truncate -s 0 MAAS-REPORT/sysinfo-report-"$ip_only"-program_analysis

printf "%s\n\033[1;32mHere is the information of the Program Communication Analysis:\033[0m%s\n"
sudo nethogs -c 30 | tee -a MAAS-REPORT/sysinfo-report-"$ip_only"-program_analysis


### System information
### sar - from sysstat package
touch MAAS-REPORT/sysinfo-report-"$ip_only"-system_information || exit
truncate -s 0 MAAS-REPORT/sysinfo-report-"$ip_only"-system_information

printf "%s\n\033[1;32mHere is the System Information Analysis:\033[0m%s\n"
export S_COLORS= && sar -A 1 1 | tee -a MAAS-REPORT/sysinfo-report-"$ip_only"-system_information


## Bring back all log to the admin
### log of SYSINFO
#sudo mkdir -p ~/MAAS-REPORT/LOG/
sudo tar czvf maas-sysinfo-log"$ip_only".tar.gz ~/MAAS-REPORT/
