#!/bin/bash

echo Register DotDeb as apt-resource
./apt/register-dotdeb.sh

echo Install Samba-mount
./samba/init.sh

# Some programms i personally like ...
echo Install htop
aptitude install htop

# Install Nginx, PHP5, MySQL and GraphicsMagick
aptitude install nginx php5-cli php5-fpm php5-mysql graphicsmagick

echo Install Apache2
./apache/init.sh

rm /var/www -R
ln -s /mnt/www /var/www