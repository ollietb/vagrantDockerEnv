#!/usr/bin/env bash

apt-get update
apt-get install -y docker-compose

useradd -m -s /bin/bash -U veselin -u 666
cp -pr /home/vagrant/.ssh /home/veselin/
cp /home/vagrant/.bashrc /home/veselin/
cp /home/vagrant/.profile /home/veselin/
cp /home/vagrant/.bash_logout /home/veselin/
chown -R veselin:veselin /home/veselin
echo "%veselin ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/veselin 