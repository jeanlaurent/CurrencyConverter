#!/bin/sh
vagrant ssh-config target > ssh-config-vagrant

host=10.10.10.11
vm=target

warfile=CurrencyConverter-1.0-SNAPSHOT.war
tomcatroot=/var/lib/tomcat7
rootfile=src/conf/ROOT.xml
webapps=$tomcatroot/webapps/

mvn clean install

scp -F ssh-config-vagrant target/$warfile $vm:~
scp -F ssh-config-vagrant $rootfile $vm:~
scp -F ssh-config-vagrant remote.sh $vm:~

ssh -t -F ssh-config-vagrant $vm "sudo ./remote.sh . $tomcatroot"

# restart
ssh -t -F ssh-config-vagrant $vm "sudo service tomcat7 restart"

# test
curl --head http://$host:8080/index.html
