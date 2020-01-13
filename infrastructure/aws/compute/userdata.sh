#!/bin/bash -v
apt-get update -y
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx