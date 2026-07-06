NAME = inception
COMPOSE = docker compose -f ./srcs/docker-compose.yml

DATA_DIR = /home/$(USER)/data
WP_DIR = $(DATA_DIR)/wordpress
DB_DIR = $(DATA_DIR)/mariadb

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
	rm -rf $(WP_DIR)/*
	rm -rf $(DB_DIR)/*

re: clean all

.PHONY: all prepare up build down clean re