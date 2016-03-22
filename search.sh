#!/bin/bash
# MAS
# Multiplexer Adminstrator Solution
# Configuration file
# License: GPL v2 or later
# Author: Aurelien DESBRIERES - aurelien@hackers.camp


# Script to search a software on remote machine

command_exists () {
    type "$1" &> /dev/null ;
}

# For Debian / Ubuntu / Trisquel / gNewSense and derivatives
if command_exists apt-cache ; then
    sudo apt-cache search  
fi

# For Archlinux / Parabola and derivatives
if command_exists pacman ; then
    sudo pacman -Ss
fi

# For Android / Cyanogen / Replicant and derivatives
if command_exists apt ; then
    sudo apt search
fi

# For RedHat / Fedora / Centos and derivatives
if command_exists dnf ; then
    sudo dnf search
else
    sudo yum search
fi
