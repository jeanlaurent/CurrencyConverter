#!/bin/sh
vagrant ssh-config > ssh-config-vagrant

host=10.11.12.13
warfile=CurrencyConverter-1.0-SNAPSHOT.war
tomcatroot=/var/lib/tomcat7
webapps=$tomcatroot/webapps/
vm=precise64

mvn clean install

scp -F ssh-config-vagrant target/$warfile $vm:~
scp -F ssh-config-vagrant remote.sh $vm:~

ssh -t -F ssh-config-vagrant $vm "sudo ./remote.sh . $tomcatroot"

# restart
ssh -t -F ssh-config-vagrant $vm "sudo service tomcat7 restart"

# test
curl --head http://$host:8080/CurrencyConverter-1.0-SNAPSHOT