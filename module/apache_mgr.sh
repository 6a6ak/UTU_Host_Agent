#!/bin/bash
f35b04
while true; do
    clear


text="\e[1m                 Apache Manager            \e[0m"
footer="\e[1m                                                \e[0m"
color="\e[48;2;243;91;4m"
width=$(tput cols)
padding=$((($width - ${#text}) ))
echo -ne "${color}${text}\033[0m\n"

echo "==========================================="
echo "  1. Install Apache       "
echo "  2. Start Apache         "
echo "  3. Stop Apache          "             
echo "  4. Restart Apache       "
echo "  5. Reload Apache        "      
echo "  6. Check Apache Status  "
echo "  7. Enable Site          "
echo "  8. Disable Site         "
echo "  9. Apache Agent         "
echo "  0. Exit                 "
echo "==========================================="
echo -n "  Enter your choice: "
read choice


    case $choice in
        1)  echo "Installing Apache..."
            sudo apt update
            sudo apt install apache2
            read -p "Press any key to continue..."
            ;;

        2)  echo "Starting Apache..."
            sudo systemctl start apache2
            read -p "Press any key to continue..."
            ;;

        3)  echo "Stopping Apache..."
            sudo systemctl stop apache2
            read -p "Press any key to continue..."
            ;;

        4)  echo "Restarting Apache..."
            sudo systemctl restart apache2
            read -p "Press any key to continue..."
            ;;

        5)  echo "Reloading Apache..."
            sudo systemctl reload apache2
            read -p "Press any key to continue..."
            ;;

        6)  echo "Apache Status:"
            sudo systemctl status apache2
            read -p "Press any key to continue..."
            ;;

        7)  echo "Available sites:"
            ls /etc/apache2/sites-available
            echo -n "Enter the site name to enable: "
            read site
            sudo a2ensite $site
            sudo systemctl reload apache2
            read -p "Press any key to continue..."
            ;;

        8)  echo "Enabled sites:"
            ls /etc/apache2/sites-enabled
            echo -n "Enter the site name to disable: "
            read site
            sudo a2dissite $site
            sudo systemctl reload apache2
            read -p "Press any key to continue..."
            ;;
        9)
            bash ./module/apache_agent.sh
            ;;

        0)  echo "Exiting..."
            exit 0
            ;;

        *)  echo "Invalid option..."
            read -p "Press any key to continue..."
            ;;
    esac
done