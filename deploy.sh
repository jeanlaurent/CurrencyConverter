#!/bin/sh

host=10.10.10.11
vm=target


warfile=CurrencyConverter-1.0-SNAPSHOT.war
tomcatroot=/var/lib/tomcat7
rootfile=src/conf/ROOT.xml
webapps=$tomcatroot/webapps/

if [ ! -f target/$warfile ]; then
	echo "Can't find war file, exiting."
	exit -1
fi

vagrant ssh target -c "sudo /vagrant/remote.sh $tomcatroot"

# test
curl --head http://$host:8080/index.html
