#!/bin/bash
# CryptoSteg
# Encrypt files and steg them to pictures

# GPLv2 or later - aurelien@hackers.camp - Aurelien DESBRIERES
# find the license at gnu.org and much more ;-)

# Variables
ENCRYPT=$"gpg -c"
DECRYPT=$"gpg"

# Clear the terminal
tput clear
# Prevent pinentry trouble with pinentry display
echo pinentry-program /usr/bin/pinentry-curses >> ~/.gnupg/gpg-agent.conf
echo RELOADAGENT | gpg-connect-agent

# Welcome
printf "\033[1;32mWelcome to CryptoSteg\n Stegagnograph and Encrypt data\n Made Simple\033[0m%s\n"

# Request the user to install or not the needed software
while true; do
    read -p "Do you need to install steghide and gpg to run CryptoSteg? Y/n " yn
    case $yn in
	[Yy]* ) # Install needed software for the operating system
	    command_exists () {
		type "$1" &> /dev/null ;
	    }
	    
	    # For Debian / Ubuntu / Trisquel / gNewSense and derivatives
	    if command_exists apt-get ; then
		sudo apt-get install steghid gnupg ;
	    fi

	    # For Archlinux / Parabola and derivatives
	    if command_exists pacman ; then
		sudo pacman -Sy steghide gnupg ;
	    fi

	    # For Android / Cyanogen / Replicant and derivatives
	    if command_exists apt ; then
		sudo apt install steghide gnupg ;
	    fi

	    # For Fedora and derivatives
	    if command_exists dnf ; then
		sudo dnf install -y steghide gnupg ;
	    fi

	    # For RedHat / CentOS and derivatives
	    if command_exists yum ; then
		sudo yum install -y steghide gnupg ;
	    fi

	    if command_exit pkg ; then
		sudo pkg install -y steghide gnupg ;
	    fi
	    break;;
	[Nn]* ) break ;;
	* ) echo "Please answer Yes or no. ";;
    esac
done
		
# Encrypt
$ENCRYPT soft_backup

# Compress
sudo tar -cf - soft_backup.gpg | xz -9 -c - > soft_backup.tar.xz

printf "Well done, soft_backup .tar.xz now contain your secret safe\n"

break;;
exit
