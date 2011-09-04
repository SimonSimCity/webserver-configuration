#!/bin/sh
###############################################
## Author:      Simon Schick
## RunAs:		root
###############################################

REPODIR=/var/svn

echo Installing subversion
apt-get install subversion

echo Create Repository-Factory
mkdir $REPODIR
chmod 770 $REPODIR

echo Starting subversion deamon
svnserve -d -r $REPODIR
