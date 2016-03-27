#!/bin/bash
# Operator
# Multiplexer Adminstrator Solution
# Configuration file
# License: GPL v2 or later
# Author: Aurelien DESBRIERES - aurelien@hackers.camp
# Operator is part of MAS - Multiplexer Adminstrator Solution


# Script to update an upgrade on the remote machine

command_exists () {
    type "$1" &> /dev/null ;
}

# For Debian / Ubuntu / Trisquel / gNewSense and derivatives
if command_exists apt-get ; then
    scp mas-log$ip_only.tar.gz operator@operator:~/MAS-REPORT/LOG/ ; exit
fi

# For Archlinux / Parabola and derivatives
if command_exists pacman ; then
    scp mas-log$ip_only.tar.gz operator@operator:~/MAS-REPORT/LOG/ ; exit
fi

# For Android / Cyanogen / Replicant and derivatives
if command_exists apt ; then
    scp mas-log$ip_only.tar.gz operator@operator:~/MAS-REPORT/LOG/ ; exit
fi

# For RedHat / Fedora / Centos and derivatives
if command_exists yum ; then
    scp mas-log$ip_only.tar.gz operator@operator:~/MAS-REPORT/LOG/ ; exit
fi
