#!/bin/bash -v
apt-get update -y
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx
echo "You reached the server" > /var/www/html/index.html