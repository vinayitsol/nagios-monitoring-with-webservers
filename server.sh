#!/bin/bash

#Installing dependencies
yum update -y
yum install httpd php -y
yum install gcc glibc glibc-common -y
yum install gd gd-devel -y

#adding nagios user and group
useradd -m nagios
echo "user created"
echo "123456" | passwd --stdin nagios
echo "setting passwd for user"
groupadd nagiosgroup
usermod -a -G nagiosgroup nagios
usermod -a -G nagiosgroup apache

#making a directory
mkdir downloads
cd downloads/

#downloading th code and extracting it
wget http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-4.0.8.tar.gz
wget http://nagios-plugins.org/download/nagios-plugins-2.0.3.tar.gz

tar -zxvf nagios-4.0.8.tar.gz
tar -zxvf nagios-plugins-2.0.3.tar.gz

#changing the location to nagios and compling the code and executing the commands
cd nagios-4.0.8/
./configure --with-command-group=nagiosgroup
make all
make install
make install-init
make install-config
make install-commandmode

#Editing the file and changing the email address
sed -i '/email/s/nagios@localhost/vinaymadivada44@gmail.com/'  /usr/local/nagios/etc/objects/contacts.cfg

#Installing web configuration
make install-webconf

#Configuring password for nagiosadmin
htpasswd -b -c  /usr/local/nagios/etc/htpasswd.users nagiosadmin nagios

#Start httpd service
systemctl start httpd

#nagios plugin installation
cd ..
cd nagios-plugins-2.0.3/


#Compiling the plugin code and executing the commands
./configure --with-nagios-user=nagios --with-nagios-group=nagios
make
make install

#Enabling the service and checking the configfile
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

#starting the service by using this command
chkconfig --add nagios
chkconfig nagios on
service nagios restart

