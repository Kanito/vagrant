#!/bin/sh

echo "Installing Jenkins..."
mkdir /home/vagrant/jenkinsinstall
cd /home/vagrant/jenkinsinstall
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install daemon
wget http://pkg.jenkins-ci.org/debian/binary/jenkins_1.525_all.deb
sudo dpkg -i jenkins_1.525_all.deb
echo "Jenkins has been successfully installed! :-)"
