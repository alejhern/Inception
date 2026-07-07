FROM debian:13

RUN apt-get update && \
    apt-get install -y \
        php8.4 \
        php8.4-fpm \
        php8.4-mysql \
        php8.4-cli \
        php8.4-curl \
        php8.4-xml \
        php8.4-mbstring \
        php8.4-zip \
        php8.4-gd \
        php8.4-redis \
        mariadb-client \
        curl && \
    rm -rf /var/lib/apt/lists/*

# Instalar WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Configuración de PHP-FPM
COPY ./conf/www.conf /etc/php/8.4/fpm/pool.d/www.conf

# Script de inicialización
COPY ./tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/setup.sh"]