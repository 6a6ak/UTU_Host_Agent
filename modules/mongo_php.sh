#!/bin/bash

# Function to install MongoDB PHP extension
function install_mongodb_extension {
    pecl install mongodb && echo "Installation command run, checking installation..."
    check_mongodb_extension
}

# Declare an array of possible paths
declare -a php_ini_paths=(
    "/etc/php/7.4/apache2/conf.d/20-mongodb.ini"
    "/etc/php/7.4/apache2/php.ini"
    "$(php --ini | grep 'Loaded Configuration File:' | awk '{print $4}')"
)

# Function to add extension to php.ini file
function add_extension_to_php_ini {
    for php_ini_path in "${php_ini_paths[@]}"
    do
        if [ -f "$php_ini_path" ]; then
            echo "extension=mongodb.so" >> $php_ini_path
            echo "extension=mongodb.so has been added to $php_ini_path."
            check_mongodb_extension "$php_ini_path"
            break
        fi
    done
}

# Function to check if MongoDB PHP extension is installed
function check_mongodb_extension {
    php_ini_path=$1
    if php -m | grep -q 'mongodb'; then
        echo "MongoDB PHP extension is present in PHP modules."
    else
        echo "MongoDB PHP extension is not present in PHP modules."
    fi
    if grep -q 'extension=mongodb.so' "$php_ini_path"; then
        echo "extension=mongodb.so is present in php.ini file."
    else
        echo "extension=mongodb.so is not present in php.ini file."
    fi
}


# Function to create a new PHP project and install MongoDB library
function create_project_and_install_mongodb_library {
    read -p "Enter the directory to create the project in: " dir
    mkdir -p "$dir" && cd "$dir" || exit
    composer init
    composer require mongodb/mongodb:^1.15
    composer show mongodb/mongodb
    echo "Project has been created and MongoDB library has been installed in the directory: $dir."
}

# Prompt user for input
echo "Please choose an option:"
echo "1) Install MongoDB PHP extension"
echo "2) Add extension=mongodb.so to php.ini"
echo "3) Check if MongoDB PHP extension is installed"
echo "4) Create a new project and install MongoDB library"
read -p "Enter option: " option

# Perform action based on user's choice
case $option in
    1)
        install_mongodb_extension
        ;;
    2)
        add_extension_to_php_ini
        ;;
    3)
        check_mongodb_extension
        ;;
    4)
        create_project_and_install_mongodb_library
        ;;
    *)
        echo "Invalid option."
        ;;
esac
