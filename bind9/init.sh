#!/bin/bash
SCRIPT_PATH="$( cd "$(dirname "$0")" && pwd )";

pacman -S --noconfirm bind > /dev/null
patch -u -p0 -d /etc/bind < $SCRIPT_PATH/patch.diff

echo "nameserver 192.168.56.10" >> /etc/resolv.conf

echo
echo "This script has appended one lines to the file /etc/resolv.conf"
read -p "Do you want to edit the file now? (y/n)"
if [[ $REPLY =~ ^[Yy]$ ]]; then
	nano /etc/resolv.conf
fi
