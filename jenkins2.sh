#!/bin/bash

url="http://localhost:8080"

function jenkins_check {
   # wait for 24*5=120 seconds
   for i in {1..24}
   do
      echo "Trying to connect to $url..."
      wget --timeout=2 -o wget.log $url
      grep "HTTP request sent, awaiting response... 200 OK" wget.log
      if [ $? -eq 0 ]
      then
         echo "Jenkins is up and running!"
         return 0
      fi
      rm -f wget.log
      sleep 5
   done
   echo "This script timed out. Is Jenkins really running?"
   return 1
}

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
sudo su jenkins -c "java -jar jenkins-cli.jar -s $url restart"
sleep 30
jenkins_check

# setup all job configurations
sudo su jenkins -c "java -jar jenkins-cli.jar -s $url create-job compile < /vagrant/jenkinsjobs/compile.xml"
sudo su jenkins -c "java -jar jenkins-cli.jar -s $url create-job unit-test < /vagrant/jenkinsjobs/unit-test.xml"
sudo su jenkins -c "java -jar jenkins-cli.jar -s $url create-job int-test < /vagrant/jenkinsjobs/int-test.xml"
sudo su jenkins -c "java -jar jenkins-cli.jar -s $url create-job database-test < /vagrant/jenkinsjobs/database-test.xml"
sudo su jenkins -c "java -jar jenkins-cli.jar -s $url create-job deploy < /vagrant/jenkinsjobs/deploy.xml"
sudo su jenkins -c "java -jar jenkins-cli.jar -s $url create-job func-test < /vagrant/jenkinsjobs/func-test.xml"

