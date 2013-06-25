#!/bin/sh
# deploy to tomcat installed via brew
target=/usr/local/Cellar/tomcat/7.0.37/libexec/webapps
package=CurrencyConverter-1.0-SNAPSHOT

catalina stop
rm -rf  $target/$package/
cp -v ./target/$package.war $target
catalina start
