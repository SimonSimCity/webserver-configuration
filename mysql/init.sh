#!/bin/bash
SCRIPT_PATH="$( cd "$(dirname "$0")" && pwd )";

aptitude -y install mysql-server > /dev/null
patch -u -p0 < patch.diff

read -p "Do you want to have a mysql-user %everyone% using no password (y/n)?"
if [[ $REPLY =~ ^[Yy]$ ]]
	mysql -u root < ./mysql/init.sql
fi

read -p "Do you want to import all sql-files matching /var/www/install-*.sql (y/n)?"
if [[ $REPLY =~ ^[Yy]$ ]]
	for fn in /var/www/install-*.sql; do
		mysql -u root < $fn
	done
fi

read -s -p "Please insert your mysql root-password: " mysqlpassword
echo
if [ -n "$mysqlpassword" ]
	mysqladmin -u root password $mysqlpassword
fi
