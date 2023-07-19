#!/bin/bash
clear

text="\e[1m                  ADBUD PHP_Tools                   \e[0m"
color="\e[48;2;71;74;138m"
width=$(tput cols)
padding=$(( ($width - ${#text})))
#tput cup 2 $padding
echo -ne "${color}${text}\033[0m\n"

while true; do
echo "Select an option:"
echo "1. Install PHP 7.4"
echo "2. Install PHP 8.2"
echo "3. Enable PHP 8.2"
echo "4. Disable PHP 8.2"
echo "0. Back to Setup"

read -p "Enter your choice: " choice

case $choice in
    1)
        sudo add-apt-repository ppa:ondrej/php -y
        sudo apt-get update
        sudo apt-get install php7.4 php7.4-cli php7.4-common php7.4-mysql php7.4-mbstring php7.4-xml php7.4-zip
        ;;
    2)
sudo dpkg -l | grep php | tee packages.txt
sudo add-apt-repository ppa:ondrej/php # Press enter when prompted.
sudo apt update
sudo apt install php8.2 php8.2-cli php-8.2{bz2,curl,mbstring,intl}
sudo apt install php8.2-fpm
sudo apt install libapache2-mod-php8.2
        ;;
    3)
        sudo a2dismod php7.4
        sudo a2enmod php8.2
        sudo service apache2 restart
        ;;
    4)
        sudo a2dismod php8.2
        sudo a2enmod php7.4
        sudo service apache2 restart
        ;;
    0)
        exit 0
        ;;
    *)
        echo "Invalid option"
        ;;
esac

done
