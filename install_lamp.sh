#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# Detect OS
if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS=$ID
  VERSION=$VERSION_ID
else
  echo "OS not supported"
  exit 1
fi

# Install LAMP stack based on the OS
install_lamp() {
  case $OS in
    almalinux|rocky|centos)
      yum update -y
      yum install -y httpd mariadb-server mariadb php php-mysqlnd
      systemctl start httpd
      systemctl enable httpd
      systemctl start mariadb
      systemctl enable mariadb
      mysql_secure_installation
      ;;
    ubuntu|debian)
      apt update
      apt install -y apache2 mariadb-server php php-mysql
      systemctl start apache2
      systemctl enable apache2
      systemctl start mariadb
      systemctl enable mariadb
      mysql_secure_installation
      ;;
    *)
      echo "OS not supported"
      exit 1
      ;;
  esac
}

install_lamp

# Display installation details
echo "LAMP installation completed."
echo "Apache version: $(apache2 -v | grep 'Server version' | awk '{print $3}')"
echo "MariaDB version: $(mysql --version)"
echo "PHP version: $(php -v | head -n 1)"
