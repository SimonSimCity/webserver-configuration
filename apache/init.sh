#!/bin/bash
SCRIPT_PATH="$( cd "$(dirname "$0")" && pwd )";

aptitude -y install apache2 libapache2-mod-fastcgi > /dev/null
patch -u -p0 -d /etc/apache2 < $SCRIPT_PATH/patch.diff

a2enmod actions > /dev/null
a2enmod vhost_alias > /dev/null
a2ensite ssc

/etc/init.d/apache2 restart > /dev/null
