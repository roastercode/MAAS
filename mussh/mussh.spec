#
# mussh spec file
# $Id: mussh.spec,v 1.10 2006-12-26 23:10:11 doughnut Exp $
#
Summary:	MUltihost SSH
Name:		mussh
Version:	1.0
Release:	1
License:	GPL
BuildArch:	noarch
BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
Group:		Applications/System
Source:		%{name}-%{version}.tgz
URL:		http://www.sourceforge.net/projects/mussh
Packager:	Dave Fogarty <dave@collegenet.com>

%description
Mussh is a shell script that allows you to execute a command or script
over ssh on multiple hosts with one command. When possible mussh will use
ssh-agent and RSA/DSA keys to minimize the need to enter your password
more than once.

%prep
rm -rf $RPM_BUILD_ROOT
%setup -n mussh

%install
mkdir -p $RPM_BUILD_ROOT/usr/bin/
mkdir -p ${RPM_BUILD_ROOT}%{_mandir}/man1/
install mussh $RPM_BUILD_ROOT/usr/bin/
gzip mussh.1
install mussh.1.gz ${RPM_BUILD_ROOT}%{_mandir}/man1/

%files
%defattr(-, root, root)
%doc INSTALL README BUGS CHANGES EXAMPLES
/usr/bin/mussh
%{_mandir}/man1/*

%changelog
* Mon Oct 25 2011 Dave Fogarty <doughnut@doughnut.net> 1.0-1
- Another fix to CTRL-\.  "HOSTS RUNNING:" was not working.
- Increased efficiency when async.  
- No more need for 'seq'.  
- Spelling correction and other minor fixes. 
- Support for netgroups added.  
- Debug mode fix when using proxy.  
- Numeric args more intuitive but backwards compatible.
- Verbose ssh now works.

* Tue Dec 26 2006 Dave Fogarty <doughnut@doughnut.net> 0.7-2
- Added ssh timeout option

* Thu Aug 23 2005 Dave Fogarty <dave@collegenet.com>
- Added manpage

* Thu Aug 11 2005 Dave Fogarty <dave@collegenet.com>
- Re-package for 0.6-1BETA
- Async mode added

* Tue Jul 30 2002 Dave Fogarty <dave@collegenet.com>
- Re-package for 0.5
