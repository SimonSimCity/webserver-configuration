#!/bin/bash
SCRIPT_PATH="$( cd "$(dirname "$0")" && pwd )";

pacman -S --noconfirm php php-apc php-fpm php-gd php-mcrypt xdebug > /dev/null
patch -u -p0 -d /etc/php5 < $SCRIPT_PATH/patch.diff
