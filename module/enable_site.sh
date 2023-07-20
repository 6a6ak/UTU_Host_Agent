#!/bin/bash

# Function to display usage
function usage() {
    echo "Usage: $0 -d domain -e email [-r]"
    echo "  -d    Domain name for the site."
    echo "  -e    Email for the ServerAdmin directive."
    echo "  -r    Disable the default site (optional)."
    exit 1
}

# Parse command line arguments
while getopts ":d:e:r" opt; do
  case ${opt} in
    d )
      domain=$OPTARG
      ;;
    e )
      email=$OPTARG
      ;;
    r )
      disable_default=true
      ;;
    \? )
      usage
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      usage
      ;;
  esac
done
shift $((OPTIND -1))

# Verify that mandatory parameters are provided
if [ -z "${domain}" ] || [ -z "${email}" ]; then
    usage
fi

# Create a directory for the website
echo "Creating directory for website..."
sudo mkdir -p /var/www/${domain}

# Copy the default configuration to create a new virtual host
echo "Creating virtual host configuration..."
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/${domain}.conf

# Edit the new virtual host file
echo "Editing virtual host configuration..."
sudo sed -i "s/#ServerName www.example.com/ServerName ${domain}/" /etc/apache2/sites-available/${domain}.conf
sudo sed -i "s/#ServerAlias www.example.com/ServerAlias www.${domain}/" /etc/apache2/sites-available/${domain}.conf
sudo sed -i "s/ServerAdmin webmaster@localhost/ServerAdmin ${email}/" /etc/apache2/sites-available/${domain}.conf
sudo sed -i "s/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/${domain}/" /etc/apache2/sites-available/${domain}.conf

# Enable the site
echo "Enabling site..."
sudo a2ensite ${domain}.conf

# Optionally disable the default site
if [ "${disable_default}" = true ]; then
    echo "Disabling default site..."
    sudo a2dissite 000-default.conf
fi

# Test the configuration and restart Apache
echo "Testing configuration..."
sudo apache2ctl configtest

echo "Restarting Apache..."
sudo systemctl restart apache2

echo "Site setup complete."
