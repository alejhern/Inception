FROM debian:13

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./conf/default.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./conf/uptime_kuma.sql /tmp/db.sql
COPY ./tools/setup.sh /setup.sh

RUN chmod +x /setup.sh

EXPOSE 3306

ENTRYPOINT ["/setup.sh"]