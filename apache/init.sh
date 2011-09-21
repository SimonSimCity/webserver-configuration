#!/bin/bash

SCRIPT_PATH="$( cd "$(dirname "$0")" && pwd )";

# Use Apache as webserver if the repository contains .htaccess files
aptitude -y install apache2 libapache2-mod-fastcgi > /dev/null
a2enmod actions > /dev/null
a2enmod vhost_alias > /dev/null

cp $SCRIPT_PATH/conf/* /etc/apache2/ -R

/etc/init.d/apache2 restart > /dev/null