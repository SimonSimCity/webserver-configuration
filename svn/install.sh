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

if [[ $1 != "" ]] ; then
	chgrp $1 $REPODIR
fi

echo Starting subversion
svnserve -d -r $REPODIR
