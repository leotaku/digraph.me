#!/usr/bin/env sh
set -e

# Install
export DEBIAN_FRONTEND=noninteractive
sudo -E apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
sudo -E apt-get -y update
sudo -E apt-get -y install curl gpg

curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo -E apt-get -y update
sudo -E apt-get -y install caddy

# Create files
mkdir -p /var/web

# Enable services
systemctl enable caddy
