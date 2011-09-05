#!/bin/bash

# Register DotDeb as last package-repository in the list
echo "" >> /etc/apt/sources.list
echo "deb http://packages.dotdeb.org stable all" >> /etc/apt/sources.list
echo "deb-src http://packages.dotdeb.org stable all" >> /etc/apt/sources.list

# Load public-key of this package-repository
wget http://www.dotdeb.org/dotdeb.gpg
cat dotdeb.gpg | apt-key add -
rm dotdeb.gpg

aptitude update
aptitude upgrade
