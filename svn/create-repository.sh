#!/bin/sh
###############################################
## Author:      Kutuma
## Blog:        http://kutuma.blogspot.com
## Authority:   http://kutuma.blogspot.com/2008/02/creating-svn-repositoy.html
## RunAs:		User who wants to access the repository
###############################################

TMPDIR=/tmp/garbage-repository
REPODIR=/var/svn
REPOURL=file://$REPODIR

if [ "$1" == "" ] ; then
    echo Usage: $0 {repository name} optional{checkout here =1}
    exit 1
fi

echo Creating directory structure
echo $TMPDIR
mkdir $TMPDIR
mkdir $TMPDIR/trunk
mkdir $TMPDIR/branches
mkdir $TMPDIR/tags

echo Creating repository $1
svnadmin create $REPODIR/$1
cd $TMPDIR
svn import $REPOURL/$1 -m "Initial structure"

if [ "$2" == "1" ] ; then
	echo Checking out
	cd -
	svn co $REPOURL/$1/trunk $1
fi

echo Cleaning up
rm -Rf $TMPDIR
echo Done!
