#!/bin/bash
service mariadb start

if [ ! -d /var/lib/mysql/${MYSQL_DATABASE} ];
then
	mariadb -u ${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE $MYSQL_DATABASE;"
	mariadb -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'"
	mariadb -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;"
	mariadb -e "FLUSH PRIVILEGES;"
	mariadb -e "ALTER USER '${MYSQL_ROOT_USER}'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
fi

mariadb-admin -u ${MYSQL_ROOT_USER} --password=${MYSQL_ROOT_PASSWORD} shutdown

mariadbd