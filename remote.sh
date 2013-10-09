#!/bin/bash
# deploy to tomcat installed via brew

package=CurrencyConverter-1.0-SNAPSHOT	

function display {
 	echo ""
    echo "* $1"
    echo ""
}

if [ -z "$tomcat_home" ]; then
	tomcat_home=/usr/local/Cellar/tomcat/7.0.41/libexec
	if [ -n "$1" ]; then
    	tomcat_home=$1
	fi
fi
echo "tomcat_home is now $tomcat_home"

webapp=$tomcat_home/webapps

service tomcat7 stop

display "removing old packages and configuration"
rm -rf  $webapp/$package/
rm $tomcat_home/conf/Catalina/localhost/ROOT.xml

display "Intalling new ROOT "
cp -v /vagrant/src/conf/ROOT.xml $tomcat_home/conf/Catalina/localhost

service tomcat7 start