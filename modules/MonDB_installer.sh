#!/bin/bash

text="\e[1m                AdBud MongoDB Installer                 \e[0m"

color="\033[32;7m"
width=$(tput cols)
padding=$(( ($width - ${#text}) / 2 ))
#tput cup 2 $padding
echo -ne "${color}${text}\033[0m\n"

# Check if the MongoDB extension is already installed
if [[ -n $(php -m | grep mongodb) ]]; then
    echo "The MongoDB extension is already installed."
else
    # Install the necessary packages
    sudo apt install php-dev php-pear

    # Install the MongoDB extension
    sudo pecl install mongodb

    # Check if the extension was installed successfully
    if [[ -z $(php -m | grep mongodb) ]]; then
        echo "The MongoDB extension was not installed successfully."
        exit 1
    fi
fi

# Prompt the user to add the extension to the php.ini file
php_ini_path=$(php --ini | grep "Loaded Configuration File" | awk '{print $4}')

echo ""
path="$php_ini_path"
dir=$(dirname "$path")

text="\e[1m The php.ini file is located at: $path \e[0m"
color="\e[91m"
width=$(tput cols)
padding=$(( ($width - ${#text}) / 2 ))
#tput cup 2 $padding
echo -e "${text}\033[0m\n"

echo -e "note: cd $dir"

# Display a message with a red background to remind the user to update the php.ini file

# Display a message in green to remind the user to update the php.ini file
echo -e "\e[91mIMPORTANT: Don't forget to add the [extension=mongodb.so] to the php.ini file!\e[0m"

echo ""
#mongodb checker in php.ini file 
extension_name="mongodb.so"
php_ini_path="/etc/php/8.2/cli/php.ini"

if [ ! -f "${php_ini_path}" ]; then
    echo "Error: php.ini file not found."
    exit 1
fi

if grep -q "extension=${extension_name}" "${php_ini_path}"; then
    echo "          The ${extension_name} extension is added to the php.ini file."
else
    echo "Error: ${extension_name} extension not found in ${php_ini_path}. Please add it and restart the web server."
    exit 1
fi
#end

echo ""

# Restart Apache to load the new extension
# Prompt the user to restart Apache
read -p "Do you want to restart Apache? [y/n] " choice
case "$choice" in 
  y|Y )
    sudo service apache2 restart
    echo "Apache restarted."
    ;;
  n|N )
    echo "Apache not restarted."
    ;;
  * )
    echo "Invalid choice. Apache not restarted."
    ;;
esac
