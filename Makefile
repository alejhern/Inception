NAME = inception
COMPOSE = docker compose -f ./srcs/docker-compose.yml

WP_DIR = ~/data/wordpress
DB_DIR = ~/data/mariadb

all: prepare
	$(COMPOSE) up -d --build

prepare:
	mkdir -p $(WP_DIR)
	mkdir -p $(DB_DIR)

up:
	$(COMPOSE) up -d

build:
	$(COMPOSE) build --no-cache

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down --volumes --rmi all --remove-orphans
	rm -rf ~/data

re: clean all

.PHONY: all prepare up build down clean re