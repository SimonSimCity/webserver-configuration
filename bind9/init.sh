#!/bin/bash
SCRIPT_PATH="$( cd "$(dirname "$0")" && pwd )";

aptitude -y install bind9 > /dev/null
patch -u -p0 -d /etc/bind < $SCRIPT_PATH/patch.diff

/etc/init.d/bind9 restart > /dev/null

echo "nameserver 192.168.56.10" >> /etc/resolv.conf

echo
echo "This script has appended one lines to the file /etc/resolv.conf"
read -p "Do you want to edit the file now? (y/n)"
if [[ $REPLY =~ ^[Yy]$ ]]; then
	editor /etc/resolv.conf
fi
