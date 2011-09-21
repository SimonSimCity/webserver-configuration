#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo Register DotDeb as apt-resource
./apt/register-dotdeb.sh

echo Install Samba-mount
./samba/init.sh

# Some programms i personally like ...
echo Install htop
aptitude -y install htop > /dev/null

# Install PHP5, MySQL and GraphicsMagick
aptitude -y install php5-cli php5-fpm php5-gd php5-mysql mysql-server graphicsmagick > /dev/null
/etc/init.d/php5-fpm restart > /dev/null

read -p "Do you want to have a mysql-user %everyone% using no password? (y|n) " -n 1
if [[ $REPLY =~ ^[Yy]$ ]]
then
	mysql -u root < ./mysql/init.sql
fi

read -s -p "Please insert your mysql root-password: " mysqlpassword
echo
if [ -n "$mysqlpassword" ]
then
	mysqladmin -u root password $mysqlpassword
fi

read -s -p "Please insert your mysql root-password: " mysqlpassword
echo
if [ -n "$mysqlpassword" ]
then
	mysqladmin -u root password $mysqlpassword
fi

# create directory for logs
[ -a /var/www/log ] || mkdir /var/www/log

echo Install and configure Apache2
./apache/init.sh

echo Install and configure nginx
./nginx/init.sh
