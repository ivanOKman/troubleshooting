# troubleshooting

| |     Issue     |  How to find  | Time to find | How to fix | Time to fix |
| :---: | -------------|-------------| ------------| ---------- | ----------- | 
| **1** | Page doesn't load  | ```Ping webserver``` | 10 min | To check internet connection and firewall (to create iptables rules if necessary |30 min| 
| **2** | Page doesn't load  | ```Curl -iL``` | 10 min | Check httpd.conf and vhost.conf |30 min| 
| **3** | App doesn't work, error page loads  | ```Service tomcat status``` | 10 min | Check log permissions, restart tomcat, look through log |30 min| 
| **4** | Service tomcat is running but the page shows errors  | ```Logs of tomcat (catalina.out)``` | 30 min | Change java alternatives, install new java | 30 min| 
| **5** | Service tomcat is running on 8080 but it doesn't redirect to 80  | ```modjk.log``` | 30 min | Check workers.properties, restart tomcat and httpd | 30 min| 
| **6** | Tomcat doesn't work after reboot  | ```Check service tomcat status, ps -aux | grep tomcat ``` | 30 min | Start tomcat service, chkconfig on |15 min| 





























