#!/bin/bash
# Operator
# Multiplexer Adminstrator Solution
# Configuration file
# License: GPL v2 or later
# Author: Aurelien DESBRIERES - aurelien@hackers.camp
# Operator is part of MAS - Multiplexer Adminstrator Solution


# Script to update an upgrade on the remote machine

user_directory=`ls /home > file ; cat file | grep -v lost+found`

chown $user_directory:$user_directory /home/$user_directory/mas-log*.tar.gz
scp /home/$user_directory/mas-log*.tar.gz operator@operator:~/ ; exit
