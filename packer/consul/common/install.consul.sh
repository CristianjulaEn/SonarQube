#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y unzip curl


# Consul Version
CONSUL_VERSION=0.7.1


# Download Consul
cd /tmp
sudo curl https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -o consul.zip
unzip consul.zip


# Install Consul
sudo chmod +x consul
mv consul /usr/bin/consul
sudo chmod 777 /usr/bin/consul


# Create config directory
sudo mkdir /etc/consul.d
sudo chmod -R 777 /etc/consul.d

# Create consul data directory
sudo mkdir /var/log/consul
sudo chmod 777 /var/log/consul