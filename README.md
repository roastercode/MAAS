# MAAS - Multiplexer Adaptive Administrator Solution

GPLv2 or later - aurelien@hackers.camp - Aurelien DESBRIERES

## MAAS is a toolkit for heterogeneous LAN and Networks that works on all your different type of OS remotely at the same time without installation.


![MAAS image](img/MAAS.png)




#### MAAS is now autonomous in front the missing MUSSH in different distro
#### But you can request your favorite distro maintainer to package it for your prefered distro ;-)

	- MUSSH - https://sourceforge.net/projects/mussh/


### It is made to works on heterogeneous LAN and Network:

	- Archlinux / Parabola and derivative
	- RedHat / Fedora / Freedora and derivative
	- Debian / Ubuntu / Trisquel and derivative
	- Android / Cyanogen / Replicant and (rooted) derivative


### How use it:

	- . run
	- Will grab the MUSSH source code (gplv2) to run it in MAS
	- It will load installation of needed dependencies of plugins
    	- It will send all needed file on remote machines

 
### What it does:

	- Update and Upgrade a cluster of different type of OS from one command
	- Install a package from the package manger of the OS
	- Load directly a command all over your hostfile
    	- Make Forensic analysis with the plugin Faron(made by MAS)
    	- Make Virus scan analysis with the plugin VirusScan(made by MAS)
    	- Bring back log or Forensic & VirusScan


### Can works with plugin

	- FARON - Forensic Analyser Remote Over Network
	  . FARON offer the tools of FAST with the power of MAS
	  . Log everything and bring them back to the admin
	- VirusScan - Scan, log and bring back log to the admin
	  . Load an up to date version of antivirus
	  . Log and bring back the log to the admin
