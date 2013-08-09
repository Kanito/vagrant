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
mkdir /home/vagrant/jenkinsplugins
cd /home/vagrant/jenkinsplugins
wget http://updates.jenkins-ci.org/download/plugins/build-pipeline-plugin/1.3.5/build-pipeline-plugin.hpi
wget http://updates.jenkins-ci.org/download/plugins/clone-workspace-scm/0.5/clone-workspace-scm.hpi
wget http://updates.jenkins-ci.org/download/plugins/credentials/1.6/credentials.hpi
wget http://updates.jenkins-ci.org/download/plugins/deploy/1.9/deploy.hpi
wget http://updates.jenkins-ci.org/download/plugins/git/1.4.0/git.hpi
wget http://updates.jenkins-ci.org/download/plugins/git-client/1.1.2/git-client.hpi
wget http://updates.jenkins-ci.org/download/plugins/greenballs/1.12/greenballs.hpi
wget http://updates.jenkins-ci.org/download/plugins/jquery/1.7.2-1/jquery.hpi
wget http://updates.jenkins-ci.org/download/plugins/parameterized-trigger/2.18/parameterized-trigger.hpi
wget http://updates.jenkins-ci.org/download/plugins/selenium/2.2/selenium.hpi
sudo su jenkins -c "cp /home/vagrant/jenkinsplugins/*.hpi /var/lib/jenkins/plugins/"

# setup jenkins configuration
cd /home/vagrant/jenkinscli
sudo su jenkins -c "cp /vagrant/jenkinsjobs/config.xml /var/lib/jenkins/"
sudo su jenkins -c "cp /vagrant/jenkinsjobs/hudson.tasks.Maven.xml /var/lib/jenkins/"

# restart jenkins
echo "Restarting Jenkins and waits until it gets up..."
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

# start compile-job
echo "Starting compile job..."
sudo su jenkins -c "java -jar jenkins-cli.jar -s $url build compile"
