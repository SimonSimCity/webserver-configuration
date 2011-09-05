#!/bin/bash

SCRIPT_PATH="$( cd "$(dirname "$0")" && pwd )";

# Install nginx
aptitude install nginx

cp $SCRIPT_PATH/conf/* /etc/nginx/ -R

/etc/init.d/nginx restart