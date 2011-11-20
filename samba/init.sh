#!/bin/bash

# Set the apache default www-root.
wwwroot="/var/www"

read -p "File system: [ \"//192.168.56.1/htdocs\" ]" fs
if [ -z "$fs" ]; then
	fs="//192.168.56.1/htdocs"
fi

read -p "Mountpoint: [ \"/mnt/www\" ]" mnt
if [ -z "$path" ]; then
  mnt="/mnt/www"
fi

read -p "Username: " username
read -s -p "Password: " password
# If you're using a read-command and unhide the user-input no new-line will be added after the command. So I do it manually
echo

# create directory if not exists or clean it up.
if [ -d "$wwwroot" ]; then
	read -p "The directory $wwwroot exists. The script will not create a symlink pointing to $mnt. You now have the possiblity to do it on another screen. Hit ENTER to continue."
else
	# create symlink from the mounted directory to $wwwroot
	ln -s $mnt $wwwroot
fi

echo Install smbfs
aptitude -y install smbfs > /dev/null

# create directory, where the resource should be mounted, if not exists
[ -a $mnt ] || mkdir $mnt

# Add the setting to load the external resource
echo "" >> /etc/fstab
echo "# nobrl parameter is important - see http://www.kitpages.fr/sf2_samba_sqlite3.php" >> /etc/fstab
echo "$fs $mnt smbfs username=$username,password=$password,uid=www-data,gid=www-data,nobrl 0 0" >> /etc/fstab

echo
echo "This script has appended three lines to the file /etc/fstab"
read -p "Do you want to edit the file now? (y/n)"
if [[ $REPLY =~ ^[Yy]$ ]]; then
	editor /etc/fstab
fi

read -p "Do you want to mount the samba resource now by reloading /etc/fstab? (y/n)"
if [[ $REPLY =~ ^[Yy]$ ]]; then
	mount -a
fi
