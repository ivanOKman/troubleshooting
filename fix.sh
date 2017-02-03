#A problem in httpd.conf was found!
#Replace the default conf with customised one...
/bin/cp /vagrant/httpd.conf /etc/httpd/conf/httpd.conf

#A problem in vhost.conf was found!
#Replace the default conf with customised one...
/bin/cp /vagrant/vhost.conf /etc/httpd/conf.d/vhost.conf

#A problem in workers.properties was found!
#Replace the default conf with customised one...
/bin/cp /vagrant/workers.properties /etc/httpd/conf.d/workers.properties

#A problem with was found!
#Use the alternatives to attach production version...
alternatives --set java /opt/oracle/java/x64//jdk1.7.0_79/bin/java

#A problem with ownership to tomcat logs was found!
#Change the permissions to tomcat user
chown -R tomcat:tomcat /opt/apache/tomcat/current/logs

#A problem with service tomcat was found!
#Edit the file /etc/init.d/tomcat and restart it then...
sed -i 's/su - tomcat/su -/g' /etc/init.d/tomcat
service tomcat restart >/dev/null 2>&1
chkconfig tomcat on

#A problem with iptables was found!
#Open ports 22 (ssh) and 80 (http) and save these rules
iptables -I INPUT -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -I INPUT -p tcp --dport 80 -m state --state NEW -j ACCEPT

#Enable /etc/sysconfig/iptables for editing and saving rules
chattr -iu /etc/sysconfig/iptables
service iptables save

#Return /etc/sysconfig/iptables to default state
chattr -iu /etc/sysconfig/iptables

#Restart tomcat and httpd and see the changes
service httpd restart
































