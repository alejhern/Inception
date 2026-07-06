#!/bin/bash

set -e

mkdir -p /etc/ssl/private
mkdir -p /etc/ssl/certs

openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt \
    -subj "/C=ES/ST=Catalonia/L=Barcelona/O=42/CN=localhost"

mkdir -p /var/www/html
cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Inception</title>
</head>
<body>
    <h1>NGINX funciona</h1>
</body>
</html>
EOF

exec nginx -g "daemon off;"