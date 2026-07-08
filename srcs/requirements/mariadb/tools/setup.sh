#!/bin/bash
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

if [ ! -d /var/lib/mysql/mysql ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

mariadbd-safe --datadir=/var/lib/mysql &

until mariadb-admin ping --silent; do
    sleep 1
done

if [ ! -f /var/lib/mysql/.initialized ]; then

    mariadb <<EOF
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;

    CREATE DATABASE IF NOT EXISTS \`${UPTIME_KUMA_DATABASE}\`;

    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';

    GRANT ALL PRIVILEGES ON \`${UPTIME_KUMA_DATABASE}\`.* TO '${MYSQL_USER}'@'%';

    FLUSH PRIVILEGES;
EOF

    touch /var/lib/mysql/.initialized
fi

mariadb-admin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown

exec mariadbd --user=mysql --console