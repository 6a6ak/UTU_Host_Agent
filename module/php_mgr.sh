#!/bin/bash
clear
echo "__________________________"
# Check the currently enabled PHP version
enabled_php_version=$(php -v | awk 'NR<=1{ print $2 }')
echo "PHP" $enabled_php_version "is Enable"
echo
echo "   Enter your choice:"
echo "   i.Need for Install"
echo "_________PHP 7.4____________"
echo "   1. Install PHP 7.4"
echo "   3. Enable PHP 7.4"
echo "   5. Disable PHP 7.4"
echo "_________PHP 8.1____________"
echo "   2. Install PHP 8.1"
echo "   4. Enable PHP 8.1"
echo "   6. Disable PHP 8.1"
echo "____________________________"
echo "   9. Alternative PHP version"
echo "   0. Exit"
read choice

case $choice in
    i)
    sudo apt install software-properties-common ca-certificates lsb-release apt-transport-https 
    
    LC_ALL=C.UTF-8 sudo add-apt-repository ppa:ondrej/php 
    
    apt-get update &&
apt-get install -y language-pack-en-base &&
export LC_ALL=en_US.UTF-8 &&
export LANG=en_US.UTF-8 &&
apt-get install -y software-properties-common &&
add-apt-repository -y ppa:ondrej/php5-5.6 &&
add-apt-repository -y ppa:ondrej/mariadb-10.0 && 
apt-get update && 
apt-get -y upgrade
    
    
    ;;
    1)
        sudo apt update
        sudo apt install php7.4
        sudo apt install libapache2-mod-php7.4
        ;;
    2)
        sudo apt update
        sudo apt install php8.1
        sudo apt install libapache2-mod-php8.1
        ;;
    3)
        sudo a2enmod php7.4
        sudo systemctl restart apache2
        ;;
    4)
        sudo a2enmod php8.1
        sudo systemctl restart apache2
        ;;
    5)
        sudo a2dismod php7.4
        sudo systemctl restart apache2
        ;;
    6)
        sudo a2dismod php8.1
        sudo systemctl restart apache2
        ;;
    7)
        sudo a2dismod php8.1
        sudo a2enmod php7.4
        sudo systemctl restart apache2
        ;;
    8)
        sudo a2dismod php7.4
        sudo a2enmod php8.1
        sudo systemctl restart apache2
        ;;
     9)
     sudo update-alternatives --config php
     ;;   
    *)
        echo "Invalid choice"
        ;;
esac
