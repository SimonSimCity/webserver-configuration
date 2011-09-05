#!/bin/bash

SCRIPT_PATH="$( cd "$(dirname "$0")" && pwd )";

# Install nginx
aptitude install nginx

cp $SCRIPT_PATH/conf/* /etc/nginx/ -R

ln -s /etc/nginx/sites-avaliable/ssc /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-avaliable/sf2 /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-avaliable/sf /etc/nginx/sites-enabled/

/etc/init.d/nginx restart