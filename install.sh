#!/bin/bash

echo Register DotDeb as apt-resource
./apt/register-dotdeb.sh

echo Install Samba-mount
./samba/init.sh

# Some programms i personally like ...
echo Install htop
aptitude install htop

# Install PHP5, MySQL and GraphicsMagick
aptitude install php5-cli php5-fpm php5-mysql mysql-server graphicsmagick
/etc/init.d/php5-fpm restart

echo Please insert the password for the MySQL user "root"
mysql -u root -p < ./mysql/init.sql

rm /var/www -R
ln -s /mnt/www /var/www

echo Install and configure nginx
./nginx/init.sh

echo Install and configure Apache2
./apache/init.sh
