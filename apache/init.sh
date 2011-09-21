#!/bin/bash

SCRIPT_PATH="$( cd "$(dirname "$0")" && pwd )";

# Use Apache as webserver if the repository contains .htaccess files
aptitude install apache2 libapache2-mod-fastcgi
a2enmod actions
a2enmod vhost_alias

cp $SCRIPT_PATH/conf/* /etc/apache2/ -R

/etc/init.d/apache2 restart