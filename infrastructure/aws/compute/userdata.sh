#!/bin/bash -v
# download cloudwatch agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/debian/amd64/latest/amazon-cloudwatch-agent.deb
dpkg -i -E ./amazon-cloudwatch-agent.deb

usermod -aG adm cwagent

# setup configuration for cloudwatch

# run cloudwatch agent

# download and start nginx
apt-get update -y
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx