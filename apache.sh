#!/bin/sh

echo "Installing Apache..."
sudo aptitude install -y apache2=2.2.22-1ubuntu1.4
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2dissite default
cp /vagrant/jenkins /etc/apache2/sites-available
sudo a2ensite jenkins
sudo apache2ctl restart
