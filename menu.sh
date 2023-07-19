#!/bin/bash
clear

text="\e[1m                 Ubuntu Host Manager            \e[0m"
footer="\e[1m                                                \e[0m"
color="\e[48;2;70;130;180m"  # Use RGB values for the desired color
width=$(tput cols)
padding=$((($width - ${#text}) ))
echo -ne "${color}${text}\033[0m\n"


# Define the main menu function
function main_menu() {
    clear
    echo "----------------------------------"
    echo "            MAIN MENU"
    echo "----------------------------------"
    echo "1. Run Apache Manager"
    echo "2. Run Apache Agent"
    echo "3. Run PHP Manager"
    echo "4. Run PHP Controler"
    echo "0. Exit"
    echo
    echo "Please enter your choice: "
    read selection
    echo
}

# Define the actions for each menu option
function menu_options() {
    case $selection in
        1) 
            echo "Apache Manager"
            bash ./module/apache_mgr.sh
            ;;
        2) 
            echo "Running Apache Agent"
            bash ./module/apache_agent.sh
            ;;
        3)
            echo "Running PHP Manager"
            bash ./module/php_mgr.sh
            ;;
        4)
            echo "Running PHP Controler"
            sudo update-alternatives --config php
            ;;
        0) 
            echo "Exiting the program"
            exit 0
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
}

# Continuously display the main menu until the user chooses to exit
while true; do
    main_menu
    menu_options
done