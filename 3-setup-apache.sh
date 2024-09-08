#!/bin/bash

echo "Create CSR"
cd ~/
openssl req -new -newkey rsa:2048 -nodes -keyout sps-api.apps.technipfmc.com.key -out sps-api.apps.technipfmc.com.csr
# TechnipFMC
# Subsea Services APAC
# christian.daquino@technipfmc.com
openssl req -new -newkey rsa:2048 -nodes -keyout sps-beta.apps.technipfmc.com.key -out sps-beta.apps.technipfmc.com.csr

openssl req -new -newkey rsa:2048 -nodes -keyout sps.apps.technipfmc.com.key -out sps.apps.technipfmc.com.csr

openssl req -new -newkey rsa:2048 -nodes -keyout sps-websockets.apps.technipfmc.com.key -out sps-websockets.apps.technipfmc.com.csr



# Copy certs to the directory
sudo cp *.pem /etc/ssl/certs
sudo cp *.key /etc/ssl/certs

echo "Create PHPInfo"
sudo mkdir /var/www/phpinfo
sudo nano /var/www/phpinfo/index.php
# <?php
#   phpinfo();
# ?>

echo "Setting Apache Server"
sudo cp /var/www/tfmch_LARAVEL/setup/apache/api.conf /etc/apache2/sites-available
sudo cp /var/www/tfmch_LARAVEL/setup/apache/api-le-ssl.conf /etc/apache2/sites-available
sudo cp /var/www/tfmch_LARAVEL/setup/apache/sps.conf /etc/apache2/sites-available
sudo cp /var/www/tfmch_LARAVEL/setup/apache/sps-le-ssl.conf /etc/apache2/sites-available
sudo cp /var/www/tfmch_LARAVEL/setup/apache/beta.conf /etc/apache2/sites-available
sudo cp /var/www/tfmch_LARAVEL/setup/apache/beta-le-ssl.conf /etc/apache2/sites-available
sudo cp /var/www/tfmch_LARAVEL/setup/apache/phpinfo.conf /etc/apache2/sites-available

sudo apachectl configtest
cd /etc/apache2/sites-available
sudo a2ensite api.conf
sudo a2ensite api-le-ssl.conf
sudo a2ensite sps.conf
sudo a2ensite sps-le-ssl.conf
sudo a2ensite beta.conf
sudo a2ensite beta-le-ssl.conf
sudo a2ensite phpinfo.conf

sudo a2dissite 000-default.conf
sudo systemctl restart apache2
sudo systemctl status apache2