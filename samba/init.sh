#!/bin/bash

echo -en "Command to recive the resources ip-address (or ip-address instead) [ \"wins_getipaddress MYHOST 192.168.56\" ]"
read host
if [ -z "$host" ]; then
  host="wins_getipaddress MYHOST 192.168.56"
fi

echo -en "Have you used the script wins_getipaddress in the last step? (yes|no) [ \"no\" ]"
read usedwins
if [ "$usedwins" = "yes" ]; then
  cp wins_getipaddress.sh /sbin/
fi

echo -en "Username: "
read username

echo -en "Password: "
read password

echo -en "Path to mount the external ressource [ \"/mnt/www\" ] "
read path
if [ -z "$path" ]; then
  path="/mnt/www"
fi

# Install the samba-client for mount
aptitude install smbfs

# create directory
[ -a $path ] || mkdir $path

# Add the command to load the external resource to rc.local
echo "" >> /etc/rc.local
echo "srv=\`$host\`" >> /etc/rc.local
echo "" >> /etc/rc.local
echo "# mount the webfolder" >> /etc/rc.local
echo "# nobrl parameter is important - see http://www.kitpages.fr/sf2_samba_sqlite3.php" >> /etc/rc.local
echo "mount -t smbfs -o username=$username,password=$password,uid=www-data,gid=www-data,nobrl //\$srv/htdocs $path" >> /etc/rc.local

echo
echo Please check your /etc/rc.local the added commands can be executed. In my case I allways have to move a "exit 0" line ...