#!/bin/sh

echo "Configuring Git..."
sudo su jenkins -c "git config --global user.email \"jenkinsuser@example.com\""
sudo su jenkins -c "git config --global user.name \"Jenkins User\""
