#!/bin/bash

# Check if the script #!/bin/bash

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
      yum install -y httpd mariadb-server mariadb php php-mysqlnd epel-release
      yum install -y phpmyadmin
      systemctl start httpd
      systemctl enable httpd
      systemctl start mariadb
      systemctl enable mariadb
      mysql_secure_installation
      ;;
    ubuntu|debian)
      apt update
      apt install -y apache2 mariadb-server php php-mysql libapache2-mod-php
      apt install -y phpmyadmin
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

# Configure phpMyAdmin
configure_phpmyadmin() {
  if [ "$OS" == "ubuntu" ] || [ "$OS" == "debian" ]; then
    echo 'Include /etc/phpmyadmin/apache.conf' >> /etc/apache2/apache2.conf
    systemctl restart apache2
  elif [ "$OS" == "almalinux" ] || [ "$OS" == "rocky" ] || [ "$OS" == "centos" ]; then
    cat <<EOT >> /etc/httpd/conf.d/phpMyAdmin.conf
Alias /phpmyadmin /usr/share/phpMyAdmin
<Directory /usr/share/phpMyAdmin/>
    AddDefaultCharset UTF-8
    <IfModule mod_authz_core.c>
        # Apache 2.4
        <RequireAny>
            Require all granted
        </RequireAny>
    </IfModule>
</Directory>
EOT
    systemctl restart httpd
  fi
}

configure_phpmyadmin

# Display installation details
echo "LAMP installation with phpMyAdmin completed."
echo "Apache version: $(apache2 -v | grep 'Server version' | awk '{print $3}')"
echo "MariaDB version: $(mysql --version)"
echo "PHP version: $(php -v | head -n 1)"
echo "phpMyAdmin is accessible at http://your_server_ip/phpmyadmin"
is run as root
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
