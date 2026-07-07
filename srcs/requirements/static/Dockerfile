FROM debian:13

RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

COPY conf/default.conf /etc/nginx/sites-available/default
COPY website/ /var/www/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]