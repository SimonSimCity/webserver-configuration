#!/bin/bash

echo Register DotDeb as apt-resource
./scripts/apt/register-dotdeb.sh

echo Install Samba-mount
aptitude install smbfs
./scripts/samba/init.sh

# Some personal-liked programms
aptitude install htop

# Install Nginx, PHP5, MySQL and GraphicsMagick
aptitude install nginx php5-cli php5-fpm php5-mysql graphicsmagick

aptitude install apache
