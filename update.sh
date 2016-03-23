#!/bin/bash
# MAS
# Multiplexer Adminstrator Solution
# Configuration file
# License: GPL v2 or later
# Author: Aurelien DESBRIERES - aurelien@hackers.camp


# Script to update an upgrade on the remote machine

command_exists () {
    type "$1" &> /dev/null ;
}

# For Debian / Ubuntu / Trisquel / gNewSense and derivatives
if command_exists apt-get ; then
    sudo apt-get update ; sudo apt-get upgrade ; exit
fi

# For Archlinux / Parabola and derivatives
if command_exists pacman ; then
    sudo pacman -Syu ; exit
fi

# For Android / Cyanogen / Replicant and derivatives
if command_exists apt ; then
    sudo apt update ; sudo apt upgrade ; exit
fi

# For RedHat / Fedora / Centos and derivatives
if command_exists dnf ; then
    sudo dnf update ; exit
elif
    sudo yum update ; exit
fi
