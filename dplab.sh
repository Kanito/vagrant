#!/bin/bash

url="http://localhost:8080"

# setup all job configurations
cd /home/vagrant/jenkinscli
sudo su jenkins -c "java -jar jenkins-cli.jar -s $url create-job compile < /vagrant/jenkinsjobs/compile.xml"
sudo su jenkins -c "java -jar jenkins-cli.jar -s $url create-job unit-test < /vagrant/jenkinsjobs/unit-test.xml"
sudo su jenkins -c "java -jar jenkins-cli.jar -s $url create-job int-test < /vagrant/jenkinsjobs/int-test.xml"
sudo su jenkins -c "java -jar jenkins-cli.jar -s $url create-job database-test < /vagrant/jenkinsjobs/database-test.xml"
sudo su jenkins -c "java -jar jenkins-cli.jar -s $url create-job deploy < /vagrant/jenkinsjobs/deploy.xml"
sudo su jenkins -c "java -jar jenkins-cli.jar -s $url create-job func-test < /vagrant/jenkinsjobs/func-test.xml"

# start compile-job
echo "Starting compile job..."
sudo su jenkins -c "java -jar jenkins-cli.jar -s $url build compile"
