#!/usr/bin/env sh
set -e

# Upgrade and install packages
export DEBIAN_FRONTEND=noninteractive
sudo -E apt-get -y update
sudo -E apt-get -y dist-upgrade
sudo -E apt-get -y install certbot

# Create web directory
mkdir -p /var/web

# Enable services
systemctl enable redbean
systemctl enable redbean-certs
