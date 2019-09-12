#!/usr/bin/env bash

# Add repositories + `apt-get update`
add-apt-repository ppa:ondrej/php # PHP
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - # Yarn
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list # Yarn
curl -sL https://deb.nodesource.com/setup_12.x | bash - # Node
apt-get update

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Initialize a Docker Swarm (some Docker Compose setups need it)
docker swarm init

# Install fish 
apt-get install -y fish
chsh -s /usr/bin/fish vagrant

# Install PHP + extensions
apt-get install -y php7.3
apt-get install -y php7.3-bcmath php7.3-bz2 php7.3-cgi php7.3-cli php7.3-curl php7.3-dba php7.3-enchant php7.3-fpm php7.3-gd php7.3-gmp php7.3-imap php7.3-interbase php7.3-intl php7.3-json php7.3-ldap php7.3-mbstring php7.3-mysql php7.3-odbc php7.3-opcache php7.3-pgsql php7.3-pspell php7.3-readline php7.3-recode php7.3-snmp php7.3-soap php7.3-sqlite3 php7.3-sybase php7.3-tidy php7.3-xml php7.3-xmlrpc php7.3-xsl php7.3-zip 

# Install Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /bin/composer

# Install Node and Yarn
apt-get install -y nodejs
apt-get install -y yarn

# Install Symfony CLI
wget https://get.symfony.com/cli/installer -O - | bash
mv /root/.symfony/bin/symfony /usr/local/bin/symfony

# Install misc. packages
apt-get install -y unzip

# https://docs.docker.com/install/linux/linux-postinstall/
usermod -aG docker vagrant

# Disable the Ubuntu MOTD
touch /home/vagrant/.hushlogin

# Disable the default fish greeting
mkdir -p /home/vagrant/.config/fish/
echo "set fish_greeting" >> /home/vagrant/.config/fish/config.fish
chown -R vagrant:vagrant /home/vagrant/.config/

# .dircolors
cp /dev_config/.dircolors /home/vagrant/.dircolors
echo "eval (dircolors -c ~/.dircolors)" >> /home/vagrant/.config/fish/config.fish

# Install `resolvconf` and add nameservers
apt-get install -y resolvconf
echo "nameserver 192.168.110.1" >> /etc/resolvconf/resolv.conf.d/head
service resolvconf restart

# Git config
su -c "git config --global credential.helper store" vagrant
su -c "git config --global user.name \"Veselin Romić\"" vagrant
su -c "git config --global user.email \"veselin.romic@infostud.com\"" vagrant

# Increase the inotify watcher limit 
echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf && sysctl -p

# Build unison from source
apt-get install -y build-essential
apt-get install -y ocaml
git clone https://github.com/bcpierce00/unison.git /root/unison-build/
cd /root/unison-build/
make UISTYLE=text
cp /root/unison-build/src/unison /bin/unison
cp /root/unison-build/src/unison-fsmonitor /bin/unison-fsmonitor
rm -rf /root/unison-build/

# Make ~/code, since unison won't
mkdir -p /home/vagrant/code/
chmod -R 777 /home/vagrant/code/
chown -R vagrant:vagrant /home/vagrant/code/

# Install and enable unison systemd service(s)
cp /dev_config/unison-code.service /etc/systemd/system/unison-code.service
systemctl enable unison-code --now