#!/bin/sh

echo "Installing Glassfish..."
mkdir ~/glassfish
cd ~/glassfish
wget http://download.java.net/glassfish/3.1.2.2/release/glassfish-3.1.2.2.zip
unzip glassfish-3.1.2.2.zip
cp /vagrant/domain.xml ~/glassfish/glassfish3/glassfish/domains/domain1/config/
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
~/glassfish/glassfish3/bin/asadmin start-domain
~/glassfish/glassfish3/glassfish/bin/asadmin set "server.java-config.java-home=/usr/lib/jvm/java-7-openjdk-amd64"
~/glassfish/glassfish3/bin/asadmin stop-domain
cp /vagrant/mysql-connector-java-5.0.8-bin.jar ~/glassfish/glassfish3/glassfish/domains/domain1/lib/ext/
~/glassfish/glassfish3/bin/asadmin start-domain
