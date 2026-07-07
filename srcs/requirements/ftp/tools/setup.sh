#!/bin/bash
set -e

# Crear usuario FTP si no existe
if ! id "$FTP_USER" >/dev/null 2>&1; then
    useradd -m -d /var/www/html -s /bin/bash "$FTP_USER"
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
    usermod -aG www-data "$FTP_USER"
fi

# Asegurar que el directorio existe
mkdir -p /var/www/html

# Mantener permisos compatibles con WordPress
chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 775 {} \;
find /var/www/html -type f -exec chmod 664 {} \;

exec vsftpd /etc/vsftpd.conf