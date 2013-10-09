#!/bin/bash

tomcat_home=$1
package=CurrencyConverter-1.0-SNAPSHOT	

function display {
 	echo ""
    echo "* $1"
    echo ""
}

service tomcat7 stop

webapp=$tomcat_home/webapps
rm -rf  $webapp/$package/
rm $tomcat_home/conf/Catalina/localhost/ROOT.xml

cp -v ~/$package.war $webapp
cp -v ~/ROOT-raw.xml $tomcat_home/conf/Catalina/localhost/ROOT.xml

service tomcat7 start