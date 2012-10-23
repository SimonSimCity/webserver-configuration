#!/bin/bash
SCRIPT_PATH="$( cd "$(dirname "$0")" && pwd )";

pacman -S --noconfirm mysql > /dev/null
cp $SCRIPT_PATH/conf/conf.d/* /etc/mysql/conf.d/

# Start MySQL to enable one of the following options
rc.d start mysqld

echo
read -p "Do you want to import all sql-files matching /var/www/install-*.sql (y/n)?"
if [[ $REPLY =~ ^[Yy]$ ]]; then
	for fn in /var/www/install-*.sql; do
		mysql -u root < $fn
	done
fi

echo
echo "The password for the mysql-user root is empty."
read -p "Do you want to run mysql_secure_installation now to secure your server (y/n)?"
if [[ $REPLY =~ ^[Yy]$ ]]; then
	mysql_secure_installation
fi

# Stop MySQL to get back to the initial state
rc.d stop mysqld
