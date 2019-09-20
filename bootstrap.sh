#!/usr/bin/env bash

apt-get update

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Initialize a Docker Swarm (some Docker Compose setups need it)
#docker swarm init

# Install misc. packages
apt-get install -y unzip build-essential

# https://docs.docker.com/install/linux/linux-postinstall/
usermod -aG docker vagrant

# Disable the Ubuntu MOTD
touch /home/vagrant/.hushlogin

# .dircolors
cp /dev_config/.dircolors /home/vagrant/.dircolors
echo "eval (dircolors -c ~/.dircolors)" >> /home/vagrant/.config/fish/config.fish

# Install `resolvconf` and add nameservers
apt-get install -y resolvconf
echo "nameserver 192.168.110.1" >> /etc/resolvconf/resolv.conf.d/head
service resolvconf restart

# Increase the inotify watcher limit 
#echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf && sysctl -p
