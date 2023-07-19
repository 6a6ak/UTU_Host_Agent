#!/bin/bash
#Header
text="\e[1m                                                                 \e[0m"
color="\e[48;2;71;74;138m"
width=$(tput cols)
padding=$(( ($width - ${#text}) / 2 ))
#tput cup 2 $padding
echo -ne "${color}${text}\033[0m\n"

text="\e[1m                  ADBUD PHP_Module_Adder v 0.9                   \e[0m"
color="\e[48;2;71;74;138m"
width=$(tput cols)
padding=$(( ($width - ${#text}) / 2 ))
#tput cup 2 $padding
echo -ne "${color}${text}\033[0m\n"

text="\e[1m                                                                 \e[0m"
color="\e[48;2;71;74;138m"
width=$(tput cols)
padding=$(( ($width - ${#text}) / 2 ))
#tput cup 2 $padding
echo -ne "${color}${text}\033[0m\n"

if [ $(dpkg-query -W -f='${Status}' curl 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo "Installing curl"
  sudo apt-get install curl
  else
  echo -e "\e[31mCurl already installed\e[0m"
fi

if [ $(dpkg-query -W -f='${Status}' php-dom 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo "Installing DOM"
  sudo apt-get install php-dom
  else
  echo -e "\e[31mDOM already installed\e[0m"
fi

if [ $(dpkg-query -W -f='${Status}' php-gd 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo "Installing GD"
  sudo apt-get install php-gd
  else
  echo -e "\e[31mGD already installed\e[0m"
fi

if [ $(dpkg-query -W -f='${Status}' php-intl 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo "Installing intl"
  sudo apt-get install php-intl
  else
  echo -e "\e[31mintl already installed\e[0m"
fi

if [ $(dpkg-query -W -f='${Status}' php-mbstring 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo "Installing mbstring"
  sudo apt-get install php-mbstring
  else
  echo -e "\e[31mmbstring already installed\e[0m"
fi

if [ $(dpkg-query -W -f='${Status}' php-mongodb 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo "Installing mongodb"
  sudo apt-get install php-mongodb
  else
  echo -e "\e[31mmongodb already installed\e[0m"
fi

if [ $(dpkg-query -W -f='${Status}' php-xml 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo "Installing SimpleXML, soap, xml, xmlreader, xmlwriter, xsl"
  sudo apt-get install php-xml
  else
  echo -e "\e[31mSimpleXML, soap, xml, xmlreader, xmlwriter, xsl already installed\e[0m"
fi

if [ $(dpkg-query -W -f='${Status}' php-zip 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo "Installing zip"
  sudo apt-get install php-zip
  else
  echo -e "\e[31mzip already installed\e[0m"
fi
