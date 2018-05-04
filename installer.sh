sudo apt-get update
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

sudo apt-get install -y vim curl git-core python-software-properties
sudo add-apt-repository -y ppa:ondrej/php

sudo apt-get update
sudo apt-get install -y php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt mysql-server php5-mysql
sudo php5enmod mcrypt
sudo service apache2 restart

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

sudo a2enmod rewrite
sudo rm -rf /var/www
sudo ln -fs /vagrant/public /var/www
sudo sed -i "s/\/var\/www\/html/\/var\/www/" /etc/apache2/sites-enabled/000-default.conf
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
sudo service apache2 restart

sudo service mysql restart
mysql -h localhost -u root -proot -e "CREATE DATABASE IF NOT EXISTS laravel50";

curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

