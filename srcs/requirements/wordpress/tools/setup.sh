#!/bin/bash

cd /var/www/html

# Esperar a MariaDB
until mariadb -h"${MYSQL_HOSTNAME}" \
    -u"${MYSQL_USER}" \
    -p"${MYSQL_PASSWORD}" \
    -e "SELECT 1;" >/dev/null 2>&1
do
    echo "Waiting for MariaDB..."
    sleep 2
done

# Descargar WordPress solo si no existe
if [ ! -f wp-config.php ]; then

    wp core download --allow-root

    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost="${MYSQL_HOSTNAME}" \
        --allow-root

    wp core install \
        --url="https://${DOMAIN_NAME}" \
        --title="${WORDPRESS_TITLE}" \
        --admin_user="${WORDPRESS_ADMIN}" \
        --admin_password="${WORDPRESS_ADMIN_PASS}" \
        --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
        --skip-email \
        --allow-root

    wp user create \
        "${WORDPRESS_USER}" \
        "${WORDPRESS_EMAIL}" \
        --role=author \
        --user_pass="${WORDPRESS_USER_PASS}" \
        --allow-root

    wp theme install twentysixteen --activate --allow-root
fi

exec php-fpm8.4 -F