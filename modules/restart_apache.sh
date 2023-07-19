sudo service apache2 restart
systemctl restart apache2
sleep 2

text="\e[1m              Apache Restarted                  \e[0m"
color="\e[44m"
width=$(tput cols)
padding=$(( ($width - ${#text}) / 2 ))
#tput cup 2 $padding
echo -ne "${color}${text}\033[0m\n"


if systemctl is-active --quiet apache2; then
  echo "Apache is active"
else
  echo "Apache is not active"
fi

