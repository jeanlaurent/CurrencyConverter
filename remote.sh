#!/bin/bash
# deploy to tomcat installed via brew
src=./target

function display {
 	echo ""
    echo "* $1"
    echo ""
}

if [ -z "$tomcat_home" ]; then
	tomcat_home=/usr/local/Cellar/tomcat/7.0.41/libexec
	if [ -n "$2" ]; then
    	tomcat_home=$2
	fi
fi
echo "tomcat_home is now $tomcat_home"

if [ -n "$1" ]; then
    src=$1
fi

target=$tomcat_home/webapps
package=CurrencyConverter-1.0-SNAPSHOT	


display "Stopping tomcat"
service tomcat7 stop

display "Intalling new package"
rootfile=ROOT.xml
rm -rf  $target/$package/
rm $target/$package.war
echo $src
cp -v $rootfile $tomcat_home/conf/Catalina/localhost

display "Starting tomcat"
service tomcat7 start

display "done."
