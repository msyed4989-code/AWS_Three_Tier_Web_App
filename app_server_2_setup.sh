cat << 'EOF' > scripts/app_server2_setup.sh
#!/bin/bash
# Script to set up App Server 2 (Apache + PHP 8.2 + phpMyAdmin)

set -e

echo "=== Updating System ==="
sudo yum update -y

echo "=== Installing PHP 8.2 & Dependencies ==="
sudo dnf install -y php8.2
sudo yum install -y php8.2-mysqlnd php-mbstring php-xml php-fpm

echo "=== Installing Apache Web Server ==="
sudo yum install -y httpd

echo "=== Starting & Enabling Services ==="
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl start php-fpm
sudo systemctl restart httpd
sudo systemctl restart php-fpm

echo "=== Setting Permissions ==="
sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;

echo "=== Downloading phpMyAdmin ==="
cd /var/www/html
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
mkdir -p phpMyAdmin 
tar -xvzf phpMyAdmin-latest-all-languages.tar.gz -C phpMyAdmin --strip-components 1
rm -f phpMyAdmin-latest-all-languages.tar.gz

echo "=== Creating Landing Page ==="
echo "PHP server 2" > /var/www/html/index.html

echo "=== Setup Complete. Verification: ==="
curl http://localhost
EOF
