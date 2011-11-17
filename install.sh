#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

echo Register DotDeb as package resource
./apt/register-dotdeb.sh

echo Install Samba-mount
./samba/init.sh

# Programms I personally like ...
echo Install htop
aptitude -y install htop > /dev/null

echo Install and configure MySQL
./mysql/init.sh

echo Install and configure PHP
./php/init.sh

echo Install GraphicsMagick
aptitude -y install graphicsmagick

# create directory for logs
[ -a /var/www/log ] || mkdir /var/www/log

echo Install and configure Apache2
./apache/init.sh

echo Install and configure nginx
./nginx/init.sh

read -p "Do you want to have Solr installed - preconfigured for TYPO3 (y/n)?"
if [[ $REPLY =~ ^[Yy]$ ]]; then
	wget http://forge.typo3.org/projects/extension-solr/repository/raw/trunk/resources/shell/install-solr.sh
	chmod +x install-solr.sh
	./install-solr.sh
fi
