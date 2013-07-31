#!/bin/sh

echo "Configuring Git..."
sudo su - jenkins
git config --global user.email "jenkinsuser@example.com"
git config --global user.name "Jenkins User"
