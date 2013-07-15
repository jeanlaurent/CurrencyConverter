#!/bin/sh
# deploy to tomcat installed via brew

if [ -z "$tomcat_home" ]; then
	echo 'tomcat_home not set, setting my own.'
	tomcat_home=/usr/local/Cellar/tomcat/7.0.41/libexec
fi

target=$tomcat_home/webapps
package=CurrencyConverter-1.0-SNAPSHOT	

 function display {
 	echo ""
    echo "* $1"
    echo ""
}

display "Stopping tomcat"
$tomcat_home/bin/catalina.sh stop

display "Intalling new package"
rm -rf  $target/$package/
rm $target/*.war
cp -v ./target/$package.war $target

display "Starting tomcat"
$tomcat_home/bin/catalina.sh start

display "done."
