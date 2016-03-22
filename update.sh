#!/bin/bash
# MAS
# Multiplexer Adminstrator Solution
# Configuration file
# License: GPL v2 or later
# Author: Aurelien DESBRIERES - aurelien@hackers.camp

command_exists () {
    type "$1" &> /dev/null ;
}

# For Debian / Ubuntu / Trisquel / gNewSense and other in the branch
if command_exists apt-get ; then
    sudo apt-get update && sudo apt-get upgrade
fi
if command_exists pacman ; then
    sudo pacman -Syu
fi
if command_exists apt ; then
    sudo apt update ; sudo apt upgrade
fi
if command_exists dnf ; then
    sudo dnf update
else
    sudo yum update
fi
