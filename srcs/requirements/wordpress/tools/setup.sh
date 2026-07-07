#!/bin/bash

set -e

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

# Instalar WordPress solo la primera vez
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

    # Redis
    wp plugin install redis-cache --activate --allow-root

    wp config set WP_REDIS_HOST "redis" --allow-root
    wp config set WP_REDIS_PORT 6379 --raw --allow-root

    # Instalar el drop-in si no existe
    if [ ! -f wp-content/object-cache.php ]; then
        cp wp-content/plugins/redis-cache/includes/object-cache.php \
           wp-content/object-cache.php
    fi

fi

# Permisos
chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 775 {} \;
find /var/www/html -type f -exec chmod 664 {} \;

exec php-fpm8.4 -F