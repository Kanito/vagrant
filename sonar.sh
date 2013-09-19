#!/bin/bash

url="http://localhost:9000"

function sonar_check {
   # wait for 24*5=120 seconds
   for i in {1..24}
   do
      echo "Trying to connect to $url..."
      wget --timeout=2 -o wget.log $url
      grep "HTTP request sent, awaiting response... 200 OK" wget.log
      if [ $? -eq 0 ]
      then
         echo "Sonar is up and running!"
         return 0
      fi
      rm -f wget.log
      sleep 5
   done
   echo "This script timed out. Is Sonar really running?"
   return 1
}

sudo sh -c 'echo deb http://downloads.sourceforge.net/project/sonar-pkg/deb binary/ > /etc/apt/sources.list.d/sonar.list'
sudo apt-get update
sudo apt-get -y --force-yes install sonar
sudo /etc/init.d/sonar start
sonar_check
