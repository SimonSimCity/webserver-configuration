#!/bin/bash
SCRIPT_PATH="$( cd "$(dirname "$0")" && pwd )";

aptitude -y install php5-apc php5-cli php5-curl php5-fpm php5-gd php5-mcrypt php5-mysql php5-xdebug php5-intl php5-sqlite > /dev/null
patch -u -p0 -d /etc/php5 < $SCRIPT_PATH/patch.diff

/etc/init.d/php5-fpm restart > /dev/null
