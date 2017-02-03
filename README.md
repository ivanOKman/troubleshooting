# troubleshooting

| |     Issue     |  How to find  | Time to find | How to fix | Time to fix |
| :---: | -------------|-------------| ------------| ---------- | ----------- | 
| **1** | Page doesn't load  | ```Ping webserver``` | 10 min | To check internet connection and firewall (to create iptables rules if necessary |30 min| 
| **2** | Page doesn't load  | ```Curl -iL``` | 10 min | Check httpd.conf and vhost.conf |30 min| 
| **3** | App doesn't work, error page loads  | ```Service tomcat status``` | 10 min | Check log permissions, restart tomcat, look through log |30 min| 
| **4** | Service tomcat is running but the page shows errors  | ```Logs of tomcat (catalina.out)``` | 30 min | Change java alternatives, install new java | 30 min| 
| **5** | Service tomcat is running on 8080 but it doesn't redirect to 80  | ```modjk.log``` | 30 min | Check workers.properties, restart tomcat and httpd | 30 min| 
| **6** | Tomcat doesn't work after reboot  | ```Check service tomcat status, ps -aux | grep tomcat ``` | 30 min | Start tomcat service, chkconfig on |15 min| 

ANSWERS TO THE QUESTIONS
1. What java version is installed? 
JAVA -VERSION. 
2. How was it installed and configured?
ALTERNATIVES --CONFIG JAVA
WHICH JAVA
FIND / -NAME JAVA 
3. Where are log files of tomcat and httpd?
Httpd logs are in /var/log/httpd/(error or access logs and so on)
Tomcat logs are in /opt/apache/tomcat/current/logs(catalina.out, access_logs and so on)
4. Where is JAVA_HOME and what is it?
JAVA_HOME is an environment variable which shows a path where Java is installed.
5. Where is tomcat installed?
WHICH tomcat, VI /etc/init.d/tomcat
6. What is CATALINA_HOME?
It is an environment variable which is used for the root of your Tomcat installation.
7. What users run httpd and tomcat processes? How is it configured?
There are such users as apache who runs httpd and tomcat -- tomcat, but there are prcoesses which are used by root. They use system ports (0 - 1024). And root have unreachable permissions. He can stop each process.
8. What configuration files are used to make components work with each other?
Vhos.conf is connected with httpd.conf, all the confs for httpd are connected with httpd.conf
9. What does it mean: “load average: 1.18, 0.95, 0.83”?
The three numbers represent averages over progressively longer periods of time (one, five, and fifteen minute averages), and that lower numbers are better.
If the number is less than 1.00 there's no reasons for worrying because CPU has no queue to perform tasks, and it doesn't perform them all the time. When LA is 1.00 it means CPU is performing tasks all the time, but has no queues. This situation is worth standing, but the situation becomes ctitical when the value is more than 1. The CPU doesn't perform all the tasks in time and it has a queue which grows more and more. We should take such tems as multi-core and multi-cpu system in consideration. If one CPU or core is loaded at the level of 90-99 it doesn't mean that the whole system performs in a bad way. You should take average power which consists of all the cores and CPUs

#My script which fixed highly mentioned problems
#fix.sh

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
#Restart httpd and see the changes
service httpd restart































