#!/bin/bash
# MAAS
# Multiplexer Adaptive Adminstrator Solution
# Configuration file

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



# Script to search a software on remote machine

command_exists () {
    type "$1" &> /dev/null ;
}

# For Debian / Ubuntu / Trisquel / gNewSense and derivatives
if command_exists apt-get ; then
    sudo apt-cache search soft_search ; exit
fi

# For Archlinux / Parabola and derivatives
if command_exists pacman ; then
    sudo pacman -Ss soft_search ; exit
fi

# For Android / Cyanogen / Replicant and derivatives
if command_exists apt ; then
    sudo apt search soft_search ; exit
fi

# For Fedora and derivatives
if command_exists dnf ; then
    sudo dnf search soft_search ; exit
fi

# For RedHat / CentOS and derivatives
if command_exists yum ; then
    sudo yum search soft_search ; exit
fi

# For FreeBSD
if command_exists pkg ; then
    sudo pkg search soft_search ; exit
fi
