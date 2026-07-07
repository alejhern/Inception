FROM debian:13

RUN apt-get update && apt-get install -y \
    vsftpd \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/vsftpd/empty

COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

EXPOSE 21 21000-21010

ENTRYPOINT ["/setup.sh"]