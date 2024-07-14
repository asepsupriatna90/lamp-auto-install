# LAMP Auto Install Script

This script automates the installation of the LAMP stack (Linux, Apache, MySQL/MariaDB, PHP) and phpMyAdmin on various Linux distributions, including AlmaLinux, RockyLinux, CentOS, Debian, and Ubuntu (20.04, 22.04, 24.04).

## Supported Operating Systems

- AlmaLinux
- RockyLinux
- CentOS
- Debian
- Ubuntu (20.04, 22.04, 24.04)

## Usage

1. Clone the repository:
    ```bash
    git clone https://github.com/asepsupriatna90/lamp-auto-install.git
    cd lamp-auto-install
    ```

2. Make the script executable:
    ```bash
    chmod +x install_lamp.sh
    ```

3. Run the script as root:
    ```bash
    sudo ./install_lamp.sh
    ```

## What the Script Does

- Updates the package list and upgrades existing packages.
- Installs Apache, MariaDB, PHP, and phpMyAdmin.
- Starts and enables Apache and MariaDB to run on boot.
- Configures phpMyAdmin for easy access.
- Runs `mysql_secure_installation` to secure the MariaDB installation.

## Post-Installation

- Apache server will be running on port 80.
- MariaDB server will be running and secured.
- PHP will be installed and configured to work with Apache.
- phpMyAdmin will be accessible at `http://your_server_ip/phpmyadmin`.

## Verifying the Installation

To verify that the installation was successful, you can check the versions of the installed components:

- Apache:
    ```bash
    apache2 -v
    ```

- MariaDB:
    ```bash
    mysql --version
    ```

- PHP:
    ```bash
    php -v
    ```

## License

This project is licensed under the MIT License.
