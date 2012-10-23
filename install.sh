#!/bin/bash


read -p "Do you have a samba shared folder you want to mount (y/n)? [ \"n\" ]"
if [[ $REPLY =~ ^[Yy]$ ]]; then
	echo Install Samba-mount
	./samba/init.sh
fi

# Programms I personally like ...
echo Install htop
pacman -S --noconfirm htop > /dev/null

echo Install and configure Bind9
./bind9/init.sh

echo Install and configure MySQL
./mysql/init.sh

echo Install and configure PHP
./php/init.sh

echo Install GraphicsMagick
pacman -S --noconfirm graphicsmagick

# create directory for logs
[ -a /var/www/log ] || mkdir /var/www/log

echo Install and configure Apache2
./apache/init.sh

echo Install and configure nginx
./nginx/init.sh

read -p "Do you want to have Solr installed - preconfigured for TYPO3 (y/n)?"
if [[ $REPLY =~ ^[Yy]$ ]]; then
	./solr/init.sh
fi
