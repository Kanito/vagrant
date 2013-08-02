#!/bin/sh

echo "Installing Selenium..."
mkdir /home/vagrant/selenium
cd /home/vagrant/selenium
wget http://selenium.googlecode.com/files/selenium-server-standalone-2.33.0.jar
wget http://selenium.googlecode.com/files/selenium-java-2.33.0.zip
unzip selenium-java-2.33.0.zip
java -jar selenium-server-standalone-2.33.0.jar -role node -hub http://localhost:4444/grid/register -browser "browserName=firefox, platform=WINDOWS, 
maxInstances=1" &
