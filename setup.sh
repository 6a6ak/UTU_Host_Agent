#!/bin/bash
clear
text="\e[1m                  Ubuntu-Web-Server-Utilities v 0.9                   \e[0m"
color="\e[44m"
width=$(tput cols)
padding=$(( ($width - ${#text}) / 2 ))
#tput cup 2 $padding
echo -ne "${color}${text}\033[0m\n"

echo "   Server installer Menu!"
# Main loop
while true; do
  # Menu options
 echo "     1. apt-update-upgrade"
 echo "     2. Install Apache"
 echo "     3. Install PHP"
 echo "     4. Install PHP Modules"
 echo "     5. Install MongoDB"
 echo "     6. Install Composer"
 echo "     7. Install Yarn"
 echo "     8. Restart Apache"   
 echo "          0. Exit"
  read -p "     Option: " option

  # Execute option
  case $option in
 1) ./modules/apt-update-upgrade.sh;;
 2) ./modules/install_apache.sh;;
 3) ./modules/install_php.sh;;
 4) ./modules/php_mdl_adder.sh;;
 5) ./modules/MonDB_installer.sh;;
 6) ./modules/install_composer.sh;;
 7) ./modules/install_yarn.sh;;
 8) ./modules/restart_apache.sh;;
 0) exit;;
    *) echo "Invalid option.";;
  esac
done
