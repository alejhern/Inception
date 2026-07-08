NAME        := inception

COMPOSE     := docker compose -f srcs/docker-compose.yml

DATA_DIR    := $(HOME)/data
WP_DIR      := $(DATA_DIR)/wordpress
DB_DIR      := $(DATA_DIR)/mariadb

UP_FLAGS    := -d
DOWN_FLAGS  := --remove-orphans
FCLEAN_FLAGS:= --volumes --rmi all --remove-orphans

all: prepare up

prepare:
	@mkdir -p $(WP_DIR) $(DB_DIR)

up:
	@echo "🚀 Starting $(NAME)..."
	@$(COMPOSE) up $(UP_FLAGS)

build:
	@echo "🔨 Building images..."
	@$(COMPOSE) up $(UP_FLAGS) --build

down:
	@echo "🛑 Stopping $(NAME)..."
	@$(COMPOSE) down

start:
	@$(COMPOSE) start

stop:
	@$(COMPOSE) stop

restart: down up

logs:
	@$(COMPOSE) logs -f

ps:
	@$(COMPOSE) ps

clean:
	@echo "🧹 Removing containers..."
	@$(COMPOSE) down $(DOWN_FLAGS)

fclean:
	@echo "🗑️ Removing containers, images and volumes..."
	@$(COMPOSE) down $(FCLEAN_FLAGS)

re: fclean build

.PHONY: all prepare up build down start stop restart logs ps clean fclean re