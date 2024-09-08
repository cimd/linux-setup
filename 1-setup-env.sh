#!/bin/bash
# Adm1nTPFMC

# SG001AZVM0001, 10.18.80.10, SPS PROD
#ssh -i sg001azvm0001_key.pem Adm1nTPFMC@10.18.80.10

# SG001AZVM0003, 10.18.325.5, SPS DEV
#ssh -i sg001azvm0003_key.pem Adm1nTPFMC@10.18.325.5

#Ubuntu Deployment
echo "Ubuntu Updates"
sudo apt-get update && sudo apt-get -y upgrade
sudo add-apt-repository ppa:ondrej/php -y
sudo apt install curl ca-certificates apt-transport-https software-properties-common -y

#Apache
echo "Instaling Apache"
sudo apt install apache2 -y
sudo ufw app info "Apache Full"
sudo ufw allow in "Apache Full"

#Maria DB
echo "Installing MariaDB"
sudo apt install mariadb-server -y
sudo systemctl status mariadb
sudo mysql -u root -e "create user admin@localhost identified by 'admin';"
sudo mysql -u root -e "grant all privileges on *.* to admin@'%' identified by 'admin'; \
flush privileges;"
sudo ufw allow 3306/tcp
sudo systemctl restart mariadb
# Configure MariaDB for remote client access: https://webdock.io/en/docs/how-guides/database-guides/how-enable-remote-access-your-mariadbmysql-database
# /etc/mysql/my.cnf
# [mysqld]
# innodb_log_file_size=512M
# innodb_flush_log_at_trx_commit=2
# innodb_buffer_pool_size=8G
# query_cache_size=16M

#PHP8
echo "Installing PHP8"
sudo apt update -y
sudo apt install -y php8.3 libapache2-mod-php8.3 php8.3-fpm libapache2-mod-fcgid php8.3-snmp php8.3-redis \
php8.3-mysql php8.3-mbstring php8.3-xml php8.3-zip php8.3-curl php8.3-gd php8.3-swoole \
php8.3-intl php8.3-bcmath
sudo a2enmod proxy proxy_http proxy_fcgi setenvif ssl expires headers mpm_event rewrite http2
sudo a2enconf php8.3-fpm
sudo systemctl restart apache2

#Composer
echo "Installing Composer"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

#Redis
echo "Installing Redis"
sudo apt install redis-server -y
sudo systemctl restart redis.service
sudo systemctl status redis

#Supervisor
echo "Installing Supervisor"
sudo apt-get -y install supervisor

# Install Meilisearch
curl -L https://install.meilisearch.com | sh
sudo mv ./meilisearch /usr/bin/

# System Timezone
echo "Setting Timezone"
sudo timedatectl set-timezone Australia/Perth
