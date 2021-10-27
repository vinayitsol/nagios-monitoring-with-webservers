#!/bin/bash
######################settingup server and client################
#Installing the git and cloning it
yum install git -y
git clone https://github.com/vinayitsol/nagios-monitoring-with-webservers.git
cd nagios-monitoring-with-webservers/

#copying the config files
rm -rf /usr/local/nagios/etc/nagios.cfg
cp nagios.cfg /usr/local/nagios/etc
rm -rf /usr/local/nagios/etc/objects/commands.cfg
cp commands.cfg /usr/local/nagios/etc/objects/
cp nginx.cfg /usr/local/nagios/etc/objects
cp tomcat.cfg  /usr/local/nagios/etc/objects

cd /usr/local/nagios/etc/objects
cp nginx.cfg apache.cfg
cp nginx.cfg dbserver.cfg
cp nginx.cfg docker.cfg


#for nginx config file
sed -i '/address/s/127.0.0.1/3.84.168.53/'  /usr/local/nagios/etc/objects/nginx.cfg

#For docker config file
sed -i '/host_name/s/nginx/docker/g'  /usr/local/nagios/etc/objects/docker.cfg
sed -i '/alias/s/nginx/docker/'  /usr/local/nagios/etc/objects/docker.cfg
sed -i '/address/s/127.0.0.1/54.92.147.52/'  /usr/local/nagios/etc/objects/docker.cfg

#for dbserver config file
sed -i '/host_name/s/nginx/dbserver/g'  /usr/local/nagios/etc/objects/dbserver.cfg
sed -i '/alias/s/nginx/dbserver/'  /usr/local/nagios/etc/objects/dbserver.cfg
sed -i '/address/s/127.0.0.1/18.210.12.43/'  /usr/local/nagios/etc/objects/dbserver.cfg

#For apache config file
sed -i '/host_name/s/nginx/apache/g'  /usr/local/nagios/etc/objects/apache.cfg
sed -i '/alias/s/nginx/apache/'  /usr/local/nagios/etc/objects/apache.cfg
sed -i '/address/s/127.0.0.1/3.81.235.1/'  /usr/local/nagios/etc/objects/apache.cfg

#for tomcat config file
sed -i '/address/s/127.0.0.1/107.22.2.211/'  /usr/local/nagios/etc/objects/tomcat.cfg

#Restarting  the service
service nagios restart
