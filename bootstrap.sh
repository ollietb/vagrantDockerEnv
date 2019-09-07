#!/usr/bin/env bash

# Add repositories + `apt-get update`
add-apt-repository ppa:ondrej/php
apt-get update

# Install Docker Compose
apt-get install -y docker-compose

# Install fish 
apt-get install -y fish

# Install PHP + extensions
apt-get install -y php7.3
apt-get install -y php7.3-bcmath php7.3-bz2 php7.3-cgi php7.3-cli php7.3-curl php7.3-dba php7.3-enchant php7.3-fpm php7.3-gd php7.3-gmp php7.3-imap php7.3-interbase php7.3-intl php7.3-json php7.3-ldap php7.3-mbstring php7.3-mysql php7.3-odbc php7.3-opcache php7.3-pgsql php7.3-pspell php7.3-readline php7.3-recode php7.3-snmp php7.3-soap php7.3-sqlite3 php7.3-sybase php7.3-tidy php7.3-xml php7.3-xmlrpc php7.3-xsl php7.3-zip 

# Create a `veselin` user and configure all the stuff he needs 
useradd -m -s /usr/bin/fish -U veselin -u 666
cp -pr /home/vagrant/.ssh /home/veselin/
cp /home/vagrant/.bashrc /home/veselin/
cp /home/vagrant/.profile /home/veselin/
cp /home/vagrant/.bash_logout /home/veselin/
chown -R veselin:veselin /home/veselin
echo "%veselin ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/veselin 

# https://docs.docker.com/install/linux/linux-postinstall/
usermod -aG docker veselin

# Disable the Ubuntu MOTD
touch /home/veselin/.hushlogin

# Disable the default fish greeting
mkdir -p /home/veselin/.config/fish/
echo "set fish_greeting" >> /home/veselin/.config/fish/config.fish
chown -R 666:666 /home/veselin/.config/