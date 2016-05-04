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
	- Will grab the MUSSH source code (gplv2) to run it in MAAS
	- It will load installation of needed dependencies of plugins
    - It will send all needed file on remote machines
    - It will execute command and plugin on remote target
    - It will bring back all actions log to the admin
 
### What it does:

	- Update and Upgrade a cluster of different type of OS from one command
	- Install a package on all the targeted machines
	- Remove a package from all the targeted machines
	- Load directly a command all over your hostfile
    - Make Forensic analysis with the plugin Faron(made by MAAS)
    - Make Virus scan analysis with the plugin VirusScan(made by MAAS)
    - Bring back log or Forensic & VirusScan
    - Make System and Hardware analysis


### Can works with plugin

	- FARON - Forensic Analyser Remote Over Network
	  . FARON offer the tools of FAST with the power of MAAS
	  . Log everything and bring them back to the admin
	- VirusScan - Scan, log and bring back log to the admin
	  . Load an up to date version of antivirus
	  . Log and bring back the log to the admin
    - SysInfo - Make a deep analysis of Hardware and System
      . Load the analysis on hardware
      . Load the analysis on the system
      . Log all the analysis

