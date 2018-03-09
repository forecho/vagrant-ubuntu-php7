#!/usr/bin/env bash
# ==================== INSTALLATION =========================

# add new repositories and install everything

# update everything if not

sudo su -


rm -r /etc/apt/sources.list

echo "deb http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list


locale-gen zh_CN.UTF-8

# ------- PPA's -------

# utility to be able to use apt-add-repository

# php7
# apt-get install software-properties-common
apt-get install python-software-properties build-essential -y
LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php -y
apt-get update > /dev/null

# install mysql
apt-get install debconf-utils -y

debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

apt-get install mysql-server -y


# install required packages
apt-get install -y php7.0 php7.0-fpm php7.0-mysql php-mongodb php-redis php7.0-curl php7.0-mcrypt php7.0-gd php7.0-cli php-xdebug php7.0-intl php-memcached php7.0-mbstring php-imagick php7.0-imap php7.0-xml php7.0-bcmath nginx curl

# install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"

mv /home/vagrant/composer.phar /usr/local/bin/composer
composer global require "fxp/composer-asset-plugin:^1.2.0"
composer self-update
composer global update --prefer-dist

cp /vagrant/vhosts/* /etc/nginx/conf.d/

# service nginx reload
# service php7.0-fpm restart

apt-get install git -y

# install autojump https://github.com/wting/autojump
git clone git://github.com/joelthelion/autojump.git /home/vagrant/autojump
cd /home/vagrant/autojump && ./install.py
sudo -H -u vagrant bash -i -c 'echo "[[ -s /root/.autojump/etc/profile.d/autojump.sh ]] && source /root/.autojump/etc/profile.d/autojump.sh">> ~/.bashrc'
