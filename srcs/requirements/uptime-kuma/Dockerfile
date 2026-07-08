FROM debian:13

RUN apt-get update && \
    apt-get install -y \
        git \
        curl \
        ca-certificates \
        nodejs \
        npm && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN git clone --depth=1 https://github.com/louislam/uptime-kuma.git

WORKDIR /opt/uptime-kuma

RUN npm install

RUN npm run build

EXPOSE 3001

CMD ["npm", "start"]