#!/bin/bash

read -p "Command to recive the resources ip-address f.e. \"wins_getipaddress MYWINSHOST 192.168.56\" [ \"echo 192.168.56.1\" ]" host
if [ -z "$host" ]; then
	host="echo 192.168.56.1"
fi

read -p "Have you used the script wins_getipaddress in the last step? (y/n) [ \"n\" ]"
if [[ $REPLY =~ ^[Yy]$ ]]; then
	cp wins_getipaddress.sh /sbin/
fi

read -p "Username: " username
read -s -p "Password: " password
# If you're using a read-command and unhide the user-input no new-line will be added after the command. So I do it manually
echo

read -p "Path to mount the external ressource [ \"/mnt/www\" ]" path
if [ -z "$path" ]; then
  path="/mnt/www"
fi

# create directory if not exists or clean it up.
if [[ -a /var/www/ ]]; then
	read -p "Currently there are some files in /var/www/. We need to remove them. Do you want to proceed (y/n)?"
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		rm /var/www/* -R
	else
		exit;
	fi
else
	mkdir /var/www/
fi

# create symlink from the mounted directory to /var/www/
ln -s $path /var/www

# Install the samba-client for mount
aptitude -y install smbfs > /dev/null

# create directory if not exists
[ -a $path ] || mkdir $path

# Add the command to load the external resource to rc.local
echo "" >> /etc/rc.local
echo "srv=\`$host\`" >> /etc/rc.local
echo "" >> /etc/rc.local
echo "# mount the webfolder" >> /etc/rc.local
echo "# nobrl parameter is important - see http://www.kitpages.fr/sf2_samba_sqlite3.php" >> /etc/rc.local
echo "mount -t smbfs -o username=$username,password=$password,uid=www-data,gid=www-data,nobrl //\$srv/htdocs $path" >> /etc/rc.local
echo "" >> /etc/rc.local
echo "# cifs client workaround" >> /etc/rc.local
echo "# @see: http://blog.dhampir.no/content/cifs-vfs-no-response-for-cmd-n-mid" >> /etc/rc.local
echo "modprobe cifs" >> /etc/rc.local
echo "echo 0 > /proc/fs/cifs/OplockEnabled" >> /etc/rc.local

echo
echo "This script has changed some settings in the file /etc/rc.local"
echo "Ensure that the commands can be executed. In my case I allways have to move a \"exit 0\" line."
read -p "Do you want to edit the file now? (y/n)"
if [[ $REPLY =~ ^[Yy]$ ]]; then
	editor /etc/rc.local
fi

read -p "Do you want to call the script /etc/rc.local now? (y/n)"
if [[ $REPLY =~ ^[Yy]$ ]]; then
	/etc/rc.local > /dev/null
fi
