#!/usr/bin/env bash
# https://ubuntuforums.org/archive/index.php/t-31247.html
# https://gist.github.com/vratiu/9780109
# Variables for colored output
COLOR_INFO='\e[1;34m'
COLOR_COMMENT='\e[0;33m'
COLOR_NOTICE='\e[1;37m'
COLOR_NONE='\e[0m' # No Color

# Intro
echo -e "${COLOR_INFO}"
echo "============================="
echo "=       Vagrant Setup       ="
echo "============================="
echo -e "${COLOR_NONE}"

# Update Packages
echo -e "${COLOR_COMMENT}"
echo "============================="
echo "=     Updating Packages     ="
echo "============================="
echo -e "${COLOR_NONE}"
sudo apt-get update

# MySQL Password
echo -e "${COLOR_COMMENT}"
echo "============================="
echo "=      MySQL Passwords      ="
echo "============================="
echo -e "${COLOR_NONE}"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

# Basic PAckage Install
echo -e "${COLOR_COMMENT}"
echo "============================="
echo "=   Basic Package Install   ="
echo "============================="
echo -e "${COLOR_NONE}"
sudo apt-get install -y vim curl git-core python-software-properties

# PHP PPA
echo -e "${COLOR_COMMENT}"
echo "============================="
echo "=          PHP PPA          ="
echo "============================="
echo -e "${COLOR_NONE}"
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update

# PHP Install
echo -e "${COLOR_COMMENT}"
echo "============================="
echo "=   Install PHP && Apache   ="
echo "============================="
echo -e "${COLOR_NONE}"
sudo apt-get install -y php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt mysql-server php5-mysql
sudo php5enmod mcrypt
sudo service apache2 restart

# Debug Install
echo -e "${COLOR_COMMENT}"
echo "============================="
echo "=      X-Debug Install      ="
echo "============================="
echo -e "${COLOR_NONE}"
sudo apt-get install -y php5-xdebug
cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
zend_extension=/usr/lib/php5/20121212/xdebug.so
xdebug.remote_connect_back = on
xdebug.default_enable = 1
xdebug.idekey = "PHPStorm"
xdebug.remote_enable = 1
xdebug.remote_autostart = 1
xdebug.remote_port = 9010
xdebug.remote_handler=dbgp
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

# Apache Settings
echo -e "${COLOR_COMMENT}"
echo "============================="
echo "=      Apache Settings      ="
echo "============================="
echo -e "${COLOR_NONE}"
sudo a2enmod rewrite
sudo rm -rf /var/www
sudo ln -fs /vagrant/public /var/www
sudo sed -i "s/\/var\/www\/html/\/var\/www/" /etc/apache2/sites-enabled/000-default.conf
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
sudo service apache2 restart

# MySQL Configuration
echo -e "${COLOR_COMMENT}"
echo "============================="
echo "=    MySQL Configuration    ="
echo "============================="
echo -e "${COLOR_NONE}"
sudo service mysql restart
mysql -h localhost -u root -proot -e "CREATE DATABASE IF NOT EXISTS prod";

# Composer
echo -e "${COLOR_COMMENT}"
echo "============================="
echo "=         Composer          ="
echo "============================="
echo -e "${COLOR_NONE}"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Laravel
echo -e "${COLOR_COMMENT}"
echo "============================="
echo "=       Laravel Setup       ="
echo "============================="
echo -e "${COLOR_NONE}"
cd /vagrant
#composer install
#php artisan setup

# Laravel
echo -e "${COLOR_INFO}"
echo "============================="
echo "=         Completed         ="
echo "============================="
echo -e "${COLOR_NONE}"
