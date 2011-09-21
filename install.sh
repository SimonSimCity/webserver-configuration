#!/bin/bash

echo Register DotDeb as apt-resource
./apt/register-dotdeb.sh

echo Install Samba-mount
./samba/init.sh

# Some programms i personally like ...
echo Install htop
aptitude install htop

# Install PHP5, MySQL and GraphicsMagick
aptitude install php5-cli php5-fpm php5-gd php5-mysql mysql-server graphicsmagick
/etc/init.d/php5-fpm restart

read -p "Do you want to have a mysql-user %everyone% using no password? (y|n) " -n 1
if [[ $REPLY =~ ^[Yy]$ ]]
then
	mysql -u root -p < ./mysql/init.sql
fi

# create directory for logs
[ -a /var/www/log ] || mkdir /var/www/log

echo Install and configure Apache2
./apache/init.sh

echo Install and configure nginx
./nginx/init.sh
