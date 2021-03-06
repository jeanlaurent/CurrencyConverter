#!/bin/sh

user=vagrant
host=10.10.10.11
vm=target


warfile=CurrencyConverter-1.0-SNAPSHOT.war
tomcatroot=/var/lib/tomcat7
rootfile=src/conf/ROOT-raw.xml
webapps=$tomcatroot/webapps/
remotescript=remote-raw.sh

if [ ! -f target/$warfile ]; then
	echo "Can't find war file, exiting."
	exit -1
fi

scp target/$warfile $user@$host:~
scp $rootfile $user@$host:~
scp $remotescript $user@$host:~

ssh -t $user@$host "sudo ~/$remotescript $tomcatroot"

# test
curl --head http://$host:8080/index.html
