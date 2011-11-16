#!/bin/bash
SCRIPT_PATH="$( cd "$(dirname "$0")" && pwd )";

aptitude -y install nginx > /dev/null

patch -u -p0 < $SCRIPT_PATH/patch.diff

ln -s /etc/nginx/sites-available/ssc /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/sf2 /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/sf /etc/nginx/sites-enabled/

/etc/init.d/nginx restart > /dev/null
