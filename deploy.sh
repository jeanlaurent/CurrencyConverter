#!/bin/sh
vagrant ssh-config > ssh-config-vagrant

host=10.11.12.13
warfile=CurrencyConverter-1.0-SNAPSHOT.war
tomcatroot=/var/lib/tomcat7
webapps=$tomcatroot/webapps/
vm=precise64

#mvn clean install
# war file
scp -F ssh-config-vagrant target/$warfile $vm:~
ssh -t -F ssh-config-vagrant $vm "sudo cp ~/$warfile $tomcatroot"

# root.xml
scp -F ssh-config-vagrant src/conf/ROOT.xml $vm:~
ssh -t -F ssh-config-vagrant $vm "sudo cp ~/ROOT.xml $tomcatroot/conf/Catalina/localhost/"

# restart
ssh -t -F ssh-config-vagrant $vm "sudo service tomcat7 restart"

# test
curl --head http://$host:8080