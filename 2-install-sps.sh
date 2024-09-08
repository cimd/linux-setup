#!/bin/bash

echo "Creating Database"
sudo mysql -u root -e "create database sps; \
grant all privileges on sps.* to admin@'%' identified by 'admin'; \
flush privileges;"

# Setup SSH and GitHub
ssh-keygen
sudo nano /etc/ssh/ssh_config
# IdentityFile /home/azureuser/.ssh/id_rsa

# Laravel
cd /var/www
sudo git clone git@github.com:cimd/tfmch_LARAVEL.git
# SPS
cd /var/www/tfmch_LARAVEL/public
sudo git clone --branch dev git@github.com:cimd/SPS.git

#/var/www/tfmch_TEST/public/SPS/dist/Staging

echo "Installing Laravel"
cd /var/www/tfmch_LARAVEL
sudo chmod -R 777 storage
sudo cp public/.htaccess.PROD .htaccess
sudo cp .env.example .env
# Configure .env at this point
# Setup DB at this point

sudo composer install --optimize-autoloader --no-dev
sudo php artisan key:generate
sudo php artisan storage:link
#sudo mysql -u root -e "create user admin@localhost identified by 'admin';"
php artisan migrate
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan event:cache

echo "Configuring Supervisor"
sudo cp /var/www/tfmch_LARAVEL/setup/workers/laravel-horizon-worker.conf /etc/supervisor/conf.d
sudo cp /var/www/tfmch_LARAVEL/setup/workers/laravel-octane-worker.conf /etc/supervisor/conf.d
sudo cp /var/www/tfmch_LARAVEL/setup/workers/meilisearch-worker.conf /etc/supervisor/conf.d

sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl start all
sudo supervisorctl status

# Configure Cron tab
# sudo crontab -e
# copy contents from ./crontab
