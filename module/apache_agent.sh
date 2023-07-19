#!/bin/bash
clear

text="\e[1m                 Apache Agent            \e[0m"
footer="\e[1m                                                \e[0m"
color="\e[48;2;243;91;4m"
width=$(tput cols)
padding=$((($width - ${#text}) ))
echo -ne "${color}${text}\033[0m\n"

# Function to backup directories
function backup {
    echo "Enter the backup directory:"
    read backup_dir
    src=$1
    dest="$backup_dir/$(basename $src)"
    echo "Backing up $src to $dest..."
    mkdir -p "$dest"
    cp -r $src $dest
}

# Function to uninstall Apache
function uninstall_apache {
    echo "Do you want to backup Apache configurations before uninstalling? (y/n)"
    read backup_before_uninstall
    if [ "$backup_before_uninstall" = "y" ]; then
        backup /etc/apache2/sites-available
        backup /etc/apache2/sites-enabled
    fi
    echo "Uninstalling Apache..."
    sudo apt-get remove apache2
}

# Function to install Apache
function install_apache {
    echo "Installing Apache..."
    # Update and upgrade packages
    sudo apt-get update
    sudo apt-get upgrade
    # Fix broken packages
    sudo dpkg --configure -a
    sudo apt-get -f install
    # Try to install Apache
    if ! sudo apt-get install apache2; then
        # If installation fails, remove all Apache packages
        sudo apt-get remove apache*
        # Try to install Apache again
        if ! sudo apt-get install apache2; then
            # If installation still fails, completely purge Apache and reinstall
            sudo apt-get purge apache2*
            sudo rm -rf /etc/apache2
            sudo apt-get install apache2
        fi
    fi
}



# Menu to select actions
while true; do
    echo "Select an action:"
    echo "1. Backup www directory"
    echo "2. Backup sites-available directory"
    echo "3. Backup sites-enabled directory"
    echo "4. Uninstall Apache"
    echo "5. Install Apache"
    echo "0. Exit"
    read option
    case "$option" in
        1) backup /var/www ;;
        2) backup /etc/apache2/sites-available ;;
        3) backup /etc/apache2/sites-enabled ;;
        4) uninstall_apache ;;
        5) install_apache ;;
        0) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option";;
    esac
done
