FROM debian:13

RUN apt-get update && apt-get install -y \
    php8.4 \
    php8.4-fpm \
    php8.4-mysql \
    wget

RUN mkdir -p /var/www/html && \
    wget -O /var/www/html/index.php \
    https://github.com/vrana/adminer/releases/download/v5.3.0/adminer-5.3.0.php

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]