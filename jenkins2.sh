#!/bin/sh

echo "Creating Jenkins jobs etc..."
mkdir /home/vagrant/jenkinscli
cd /home/vagrant/jenkinscli
wget http://localhost:8080/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s http://localhost:8080 create-job compile < /vagrant/jenkinsjobs/compile.xml
java -jar jenkins-cli.jar -s http://localhost:8080 create-job unit-test < /vagrant/jenkinsjobs/unit-test.xml
java -jar jenkins-cli.jar -s http://localhost:8080 create-job int-test < /vagrant/jenkinsjobs/int-test.xml
java -jar jenkins-cli.jar -s http://localhost:8080 create-job database-test < /vagrant/jenkinsjobs/database-test.xml
java -jar jenkins-cli.jar -s http://localhost:8080 create-job deploy < /vagrant/jenkinsjobs/deploy.xml
java -jar jenkins-cli.jar -s http://localhost:8080 create-job func-test < /vagrant/jenkinsjobs/func-test.xml
mkdir -p /var/lib/jenkins/workspace/compile
cp -r /vagrant/pipeline /var/lib/jenkins/workspace/compile/
cp /vagrant/jenkinsjobs/config.xml /var/lib/jenkins/

