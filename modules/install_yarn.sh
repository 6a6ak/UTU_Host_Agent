#!/bin/bash
text="\e[1m                  AdBud Yarn Installer                    \e[0m"

color="\e[48;5;31m"
width=$(tput cols)
padding=$(( ($width - ${#text}) / 2 ))
#tput cup 2 $padding
echo -ne "${color}${text}\033[0m\n"

echo -e ""

if ! [ -x "$(command -v yarn)" ]; then
  echo "Yarn is not installed."
  read -p "Would you like to install it? (U)ninstall/(I)nstall/(E)xit: " choice
  case "$choice" in 
    U|u ) echo "Uninstalling Yarn..."
          sudo apt-get remove yarn
          echo "Yarn has been uninstalled."
          ;;
    I|i ) echo "Installing Yarn..."
          sudo apt-get install yarn
          echo "Yarn has been installed."
          ;;
    E|e ) echo "Exiting script."
          exit 0
          ;;
    * )   echo "Invalid choice. Exiting script."
          exit 1
          ;;
  esac
else
  echo "Yarn is already installed."
fi
