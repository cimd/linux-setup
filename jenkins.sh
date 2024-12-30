#!/bin/sh

# https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-22-04
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key |sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg
sudo sh -c 'echo deb [trusted=yes signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y

sudo systemctl start jenkins.service
sudo ufw allow 8080
sudo ufw status
