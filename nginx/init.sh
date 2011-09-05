#!/bin/bash

SCRIPT_PATH="$( cd "$(dirname "$0")" && pwd )";

# Install nginx
aptitude install nginx

mv $SCRIPT_PATH/conf/* /etc/nginx/

/etc/init.d/nginx restart