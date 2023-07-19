#!/bin/bash

text="\e[1m                  ♫ AdBud Composer Installer ♫                   \e[0m"

color="\033[48;2;224;74;60m"
width=$(tput cols)
padding=$(( ($width - ${#text}) / 2 ))
#tput cup 2 $padding
echo -ne "${color}${text}\033[0m\n"
echo -e ""

# Check if Composer is already installed
if ! [ -x "$(command -v composer)" ]; then
  echo "Composer is not installed."
else
  echo "Composer version: $(composer --version)"
fi

# Ask user if they want to install or uninstall Composer
echo "Do you want to install or uninstall Composer? (i/u)"
read install_uninstall

if [ "$install_uninstall" == "i" ]; then
  # Install dependencies
  sudo apt-get update
  sudo apt-get install curl php-cli php-mbstring git unzip
  
  # Install Composer
  sudo curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
  
  echo "Composer has been installed."
elif [ "$install_uninstall" == "u" ]; then
  # Uninstall Composer
  sudo rm /usr/local/bin/composer
  
  echo "Composer has been uninstalled."
else
  echo "Invalid option selected. Please try again."
fi

