#!/bin/bash

text="\e[1m                  Apache Tools                   \e[0m"

color="\e[44m"
width=$(tput cols)
padding=$(( ($width - ${#text}) / 2 ))
#tput cup 2 $padding
echo -ne "${color}${text}\033[0m\n"

function uninstall_apache {
    # Stop the Apache service
    sudo systemctl stop apache2

    # Remove Apache packages and its configuration files
    sudo apt-get remove --purge apache2 apache2-utils apache2-bin
    sudo apt-get autoremove
    sudo rm -rf /etc/apache2/

    # Remove Apache user and group
    sudo deluser www-data
    sudo delgroup www-data

    # Remove the www directory if the user chooses to do so
    read -p "Do you want to remove the Apache www directory? (y/n) " -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        sudo rm -rf /var/www/
        echo "Apache www directory has been removed."
    else
        echo "Apache www directory has not been removed."
    fi
}

function install_apache {
    # Install Apache
    sudo apt-get update
    sudo apt-get install apache2
}

function restart_apache {
    # Restart the Apache service
    sudo systemctl restart apache2
}

function restart_server {
    # Restart the server
    sudo reboot
}

# Display the options to the user
echo "Select an option:"
echo "1. Install Apache"
echo "2. Uninstall Apache"
echo "3. Restart Apache"
echo "4. Restart Server"
echo "5. Back to Setup"

# Get the user's choice
read choice

# Process the user's choice
case $choice in
    1)
        install_apache
        ;;
    2)
        uninstall_apache
        ;;
    3)
        restart_apache
        ;;
    4)
        restart_server
        ;;
    5)
        ../setup.sh
        ;;
    *)
        echo "Invalid choice"
        ;;
esac


