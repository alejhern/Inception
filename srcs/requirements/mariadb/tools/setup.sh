#!/bin/bash

# Inicializar la base de datos si no existe
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Arrancar MariaDB temporalmente
mysqld_safe --datadir=/var/lib/mysql &

# Esperar a que esté disponible
until mariadb-admin ping --silent; do
    sleep 1
done

# Crear base de datos y usuarios solo la primera vez
mariadb -u root << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';

FLUSH PRIVILEGES;
EOF

# Parar la instancia temporal
mariadb-admin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Arrancar MariaDB en primer plano
exec mariadbd --user=mysql --console