## laravel 5

Run in local with:
10.0.1.105

Read Vagrantfile

Run in the C9.io
Edit the file:
/etc/apache2/sites-enabled/001-cloud9.conf
DocumentRoot /home/ubuntu/workspace/public
...
Run in codeenvy
Edit the file
vim /etc/apache2/sites-enabled/000-default.conf
-----------------------------
## Running All Outstanding Migrations
php artisan migrate
-----------------------------
#sudo php5dismod xdebug
sudo service apache2 restart
