#!/bin/bash
#Login NagiOS Server & Install Dependency Package
yum update -y
yum install perl-XML-XPath perl-libwww-perl -y

#Download check_tomcat.pl
cd /usr/local/nagios/libexec
curl "https://exchange.nagios.org/components/com_mtree/attachment.php?link_id=2522&cf_id=24" -o check_tomcat.pl
chmod +x /usr/local/nagios/libexec/check_tomcat.pl

#Test check_tomcat.pl
./check_tomcat.pl  -h
./check_tomcat.pl -I  107.22.2.211 -p 8080 -l manager -a 123456789 -w 20%,30% -c 10%,20%

#check Nagios configurations and restart
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

#Restarting  the service
service nagios restart 
