FROM debian:13

RUN apt-get update && \
    apt-get install -y curl ca-certificates nodejs npm git && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/louislam/uptime-kuma.git /opt/uptime-kuma

WORKDIR /opt/uptime-kuma

RUN npm install

COPY ./tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

EXPOSE 3001

ENTRYPOINT ["/setup.sh"]