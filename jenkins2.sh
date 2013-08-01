#!/bin/sh

echo "Creating Jenkins jobs etc..."
mkdir /home/vagrant/jenkinscli
chmod -R 777 /home/vagrant/jenkinscli
cd /home/vagrant/jenkinscli
wget http://localhost:8080/jnlpJars/jenkins-cli.jar

# install all plugins
sudo su jenkins -c "cp /vagrant/jenkinsplugins/*.hpi /var/lib/jenkins/plugins/"

# setup jenkins configuration
sudo su jenkins -c "cp /vagrant/jenkinsjobs/config.xml /var/lib/jenkins/"
sudo su jenkins -c "cp /vagrant/jenkinsjobs/hudson.tasks.Maven.xml /var/lib/jenkins/"

# restart jenkins
sudo su jenkins -c "java -jar jenkins-cli.jar -s http://localhost:8080 restart"
echo "Sleeping for 60 seconds and waiting for Jenkins to wake up..."
sleep 60

# setup all job configurations
sudo su jenkins -c "java -jar jenkins-cli.jar -s http://localhost:8080 create-job compile < /vagrant/jenkinsjobs/compile.xml"
sudo su jenkins -c "java -jar jenkins-cli.jar -s http://localhost:8080 create-job unit-test < /vagrant/jenkinsjobs/unit-test.xml"
sudo su jenkins -c "java -jar jenkins-cli.jar -s http://localhost:8080 create-job int-test < /vagrant/jenkinsjobs/int-test.xml"
sudo su jenkins -c "java -jar jenkins-cli.jar -s http://localhost:8080 create-job database-test < /vagrant/jenkinsjobs/database-test.xml"
sudo su jenkins -c "java -jar jenkins-cli.jar -s http://localhost:8080 create-job deploy < /vagrant/jenkinsjobs/deploy.xml"
sudo su jenkins -c "java -jar jenkins-cli.jar -s http://localhost:8080 create-job func-test < /vagrant/jenkinsjobs/func-test.xml"

