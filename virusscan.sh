#!/bin/bash
# VirusScan & report log
# Multiplexer Administrator Solution

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


# VirusScan is part of MAAS
# https://github.com/aurelien-git/MAAS

tput clear # clear the terminal

printf "\033[1;32mWelcome to FARON - Forensic Analyser Remote Over Network\033[0m%s\n"
printf "\033[1;32mFARON is made to run as a MAAS dependencie\033[0m%s\n"
printf "\033[1;32mFARON will run during more than one hour!\033[0m%s\n"

# Register the user identification during process
printf "\033[1;32m%s\nRegistering you identification during the MAAS process\033[0m%s\n"
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
    sudo apt-get install clamav clamav-freshclam clamdscan gawk ; exit
fi

# For Archlinux / Parabola and derivatives
if command_exists pacman ; then
    sudo pacman -Sy clamav iw clamav-freshclam clamdscan gawk ; exit
fi

# For Android / Cyanogen / Replicant and derivatives
if command_exists apt ; then
    sudo apt install clamav iw clamav-freshclam clamdscan gawk ; exit
fi

# For Fedora and derivatives
if command_exists dnf ; then
    sudo dnf install -y clamav iw clamav-freshclam clamdscan gawk ; exit
fi

# For RedHat / CentOS and derivatives
if command_exists yum ; then
    sudo yum install -y clamav iw clamav-freshclam clamdscan gawk ; exit
fi

# For Gentoo
if command_exists emerge ; then
    sudo emerge --ask -y clamav iw clamav-freshclam clamdscan gawk ; exit
fi

# For Sabayon
if command_exit equo ; then
    sudo equo install -y clamav iw clamav-freshclam clamdscan gawk ; exit
fi

# For FreeBSD
if command_exists pkg ; then
    sudo pkg install -y clamav iw clamav-freshclam clamdscan gawk ; exit
fi

# command
the_user="$(whoami)"
ip_only="$(awk -F'[ /]+'  '/inet /{print $3}')"
firewall="$(sudo iptables -L)"
virusscan="$(sudo freshclam && sudo clamscan -ri --log=clam-log --cross-fs=yes /)"
sudo mkdir -p MAAS-REPORT

## Virus analysis
### scan all type of filesystem

touch MAAS-REPORT/faron-report-"$ip_only"-virus || exit
truncate -s 0 MAAS-REPORT/faron-report-"$ip_only"-virus

printf "%s\n\033[1;32mYour firewall rules are:\033[0m\n$firewall%s\n" | tee -a MAAS-REPORT/faron-report-"$ip_only"-virus

# request what the admin want
printf "%s\n\033[1;32mScanning against virus will take more than one hour\033[0m%s\n"
"$virusscan"
printf "\033[1;32mResult of the virus scan:\033[0m\n$virusscan%s\n" | tee -a MAAS-REPORT/faron-report-"$ip_only"-virus


## Bring back all log to the admin
mkdir -p ~/MAAS-REPORT/LOG/
sudo tar czvf maas-virus-log"$ip_only".tar.gz ~/MAAS-REPORT/LOG/
