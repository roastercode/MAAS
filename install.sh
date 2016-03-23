#!/bin/bash
# MAS
# Multiplexer Adminstrator Solution
# Configuration file
# License: GPL v2 or later
# Author: Aurelien DESBRIERES - aurelien@hackers.camp


# Script to install a software on remote machine


command_exists () {
    type "$1" &> /dev/null ;
}

# For Debian / Ubuntu / Trisquel / gNewSense and derivatives
if command_exists apt-get ; then
    sudo apt-get install soft_install ; exit
fi

# For Archlinux / Parabola and derivatives
if command_exists pacman ; then
    sudo pacman -Sy soft_install ; exit
fi

# For Android / Cyanogen / Replicant and derivatives
if command_exists apt ; then
    sudo apt install soft_install ; exit
fi

# For RedHat / Fedora / Centos and derivatives
if command_exists dnf ; then
    sudo dnf install soft_install ; exit
elif
    sudo yum install soft_install ; exit
fi
