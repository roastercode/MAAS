# MAAS - Scalable cluster administration Bash framework

GPLv2 or later - hello@roastercode.com

[![GitHub Stats](https://img.shields.io/badge/github-stats-ff5500.svg)](http://githubstats.com/aurelien-git/MAAS)


## MAAS is a toolkit for a full control of your Datacenter heterogeneous or not.
Fully written in 1000 lines of Bash it is made readable for security.

You need a new action to your full datacenter? just write the Bash file that need to be executed, or launch directly your command line.

Some people use complex and unreadable tools like ANSIBLE, Puppet or Chef.

With MAAS, you just need to write what you want or execute already existant added tools.

You think your tools should be added to MAAS? Just told us!


![MAAS image](img/MAAS.png)




#### MAAS is now autonomous in front the missing MUSSH in different distro
#### But you can request your favorite distro maintainer to package it for your prefered distro ;-)

	- MUSSH - https://sourceforge.net/projects/mussh/


### It is made to works on heterogeneous LAN and Network:

	- Archlinux / Parabola and derivative
	- RedHat / Fedora / Freedora and derivative
	- Debian / Ubuntu / Trisquel and derivative
	- Android / Cyanogen / Replicant and (rooted) derivative
	- FreeBSD
	- Gentoo
	- Sabayon

### How use it:

	- sudo sh run
	- Load installation of needed dependencies of plugins
    - Send all needed file on remote machines
    - Execute command and plugin on remote target
    - Bring back all actions log to the admin
	- At the time you already have run the run file you can just do: sudo sh maas

### What it does:

	- Update and Upgrade a cluster of different type of OS from one command
	- Install a package on all the targeted machines
	- Remove a package from all the targeted machines
	- Transfert files to remote target
	- Load directly a command all over your hostfile
    - Make Forensic analysis with the plugin Faron (made by MAAS)
    - Make Virus scan analysis with the plugin VirusScan (made by MAAS)
    - Bring back log or Forensic & VirusScan
    - Make System and Hardware analysis
	- Backup your remote data to encrypted gpg solution and bring it back to you


### Can works with plugin

	- FARON - Forensic Analyser Remote Over Network
	  . FARON offer the tools of FAST rewritten and shellcheck with the power of MAAS
	  . Log everything and bring them back to the admin
	- VirusScan - Scan, log and bring back log to the admin
	  . Load an up to date version of antivirus
	  . Log and bring back the log to the admin
    - SysInfo - Make a deep analysis of Hardware and System
      . Load the analysis on hardware
      . Load the analysis on the system
      . Log all the analysis
	- CryptoSteg - Encryption + Steganography of your data
	  . Encrypt / Decrypt your data + use steganography solution to improve security level of all your target
	- MI (Mass Install) - It offer you the way to install the software you wish on all your target
	- Remove - It offer you the way to remove the software you wish on all your target
	- Update - It offer you the way to update / upgrade all your target

#### M.A.A.S. Is now at Savanah \o/
