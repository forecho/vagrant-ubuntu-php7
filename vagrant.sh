#!/usr/bin/env bash
# ==================== INSTALLATION =========================

# add new repositories and install everything

# update everything if not

sudo su -

echo "deb http://mirrors.163.com/ubuntu/ precise main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ precise-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ precise-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ precise-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ precise-backports main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ precise main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ precise-security main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ precise-updates main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ precise-proposed main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ precise-backports main restricted universe multiverse" >> /etc/apt/sources.list

# ------- PPA's -------

# utility to be able to use apt-add-repository
apt-get install -y python-software-properties

#php7
LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

apt-get update

# install mysql
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
apt-get update
apt-get install -y mysql-server

# install required packages
apt-get install -y php7.0 php7.0-fpm php7.0-mysql php-mongodb php-redis php7.0-curl php7.0-mcrypt php7.0-gd php7.0-cli php-xdebug php7.0-intl php-memcached php7.0-imap nginx curl

# install composer
if [ ! -f /usr/local/bin/composer ]; then
  curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
  composer global require "fxp/composer-asset-plugin:~1.1.1"
else
  composer self-update
  composer global update --prefer-dist
fi

echo 'include /vagrant/vhosts/*;' >> /etc/nginx/sites-enabled/default