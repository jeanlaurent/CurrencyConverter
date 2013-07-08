#!/bin/sh
# deploy to tomcat installed via brew
target=/usr/local/Cellar/tomcat/7.0.41/libexec/webapps
package=CurrencyConverter-1.0-SNAPSHOT

 function display {
 	echo ""
    echo "* $1"
    echo ""
}


display "Stopping tomcat"
catalina stop

display "Intalling new package"
rm -rf  $target/$package/
rm $target/*.war
cp -v ./target/$package.war $target

display "Starting tomcat"
catalina start

display "done."