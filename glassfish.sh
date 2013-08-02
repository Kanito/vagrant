#!/bin/sh

echo "Installing Glassfish..."
mkdir /home/vagrant/glassfish
cd /home/vagrant/glassfish
wget http://download.java.net/glassfish/3.1.2.2/release/glassfish-3.1.2.2.zip
unzip glassfish-3.1.2.2.zip
cp /vagrant/domain.xml /home/vagrant/glassfish/glassfish3/glassfish/domains/domain1/config/
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
/home/vagrant/glassfish/glassfish3/bin/asadmin start-domain
/home/vagrant/glassfish/glassfish3/glassfish/bin/asadmin set "server.java-config.java-home=/usr/lib/jvm/java-7-openjdk-amd64"
/home/vagrant/glassfish/glassfish3/bin/asadmin stop-domain
cp /vagrant/mysql-connector-java-5.0.8-bin.jar /home/vagrant/glassfish/glassfish3/glassfish/domains/domain1/lib/ext/
/home/vagrant/glassfish/glassfish3/bin/asadmin start-domain
