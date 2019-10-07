#!/usr/bin/env bash

add-apt-repository ppa:ondrej/php # PHP
apt-get update

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Initialize a Docker Swarm (some Docker Compose setups need it)
#docker swarm init


# Install PHP + extensions
apt-get install -y php7.3
apt-get install -y php7.3-bcmath php7.3-bz2 php7.3-cgi php7.3-cli php7.3-curl php7.3-dba php7.3-enchant php7.3-fpm php7.3-gd php7.3-gmp php7.3-imap php7.3-interbase php7.3-intl php7.3-json php7.3-ldap php7.3-mbstring php7.3-mysql php7.3-odbc php7.3-opcache php7.3-pgsql php7.3-pspell php7.3-readline php7.3-recode php7.3-snmp php7.3-soap php7.3-sqlite3 php7.3-sybase php7.3-tidy php7.3-xml php7.3-xmlrpc php7.3-xsl php7.3-zip 

# Install Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /bin/composer


# Install misc. packages
apt-get install -y unzip build-essential

# https://docs.docker.com/install/linux/linux-postinstall/
usermod -aG docker vagrant

# Disable the Ubuntu MOTD
touch /home/vagrant/.hushlogin


# Install `resolvconf` and add nameservers
apt-get install -y resolvconf
echo "nameserver 8.8.8.8" > /etc/resolvconf/resolv.conf.d/head
service resolvconf restart

apt remove -y apache2

# Increase the inotify watcher limit 
#echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf && sysctl -p
