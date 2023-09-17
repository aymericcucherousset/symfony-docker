# Variables
DOCKER = docker
DOCKER_COMPOSE = docker-compose
DOCKER_APP = template_app_sf# APP container name
DOCKER_DB = template_db# DB container name
APP_FOLDER = app
EXEC = $(DOCKER) exec -w /var/www/$(APP_FOLDER) $(DOCKER_APP)
EXEC_WITHOUT_APP_PATH = $(DOCKER) exec -w /var/www/ $(DOCKER_APP)
PHP = $(EXEC) php
COMPOSER = $(EXEC) composer
NPM = $(EXEC) npm
SYMFONY_CONSOLE = $(PHP) app/bin/console
RM = rm -rf
WEB_HTTP_SERVER_PORT=8080# On change, change WEB_HTTP_SERVER_PORT in .env file

DOCKER_COMPOSE_FILE = docker-compose.yaml
DOCKER_COMPOSE_FILE_DEV = docker-compose.dev.yaml

# Colors
GREEN = /bin/echo -e "\x1b[32m\#\# $1\x1b[0m"
RED = /bin/echo -e "\x1b[31m\#\# $1\x1b[0m"

include Makefiles/Makefile.app.mk
include Makefiles/Makefile.docker.mk
include Makefiles/Makefile.composer.mk
include Makefiles/Makefile.symfony.mk
include Makefiles/Makefile.npm.mk

## —— 🧰 Tools ——
config-git: ## Configure git
	$(EXEC) git config --global user.email "docker@localhost"
	$(EXEC) git config --global user.name "Docker"

configure-database-url: ## Configure DATABASE_URL in .env file (Change the host(127.0.0.1) by the db name in docker (DOCKER_DB)
	$(EXEC) sed -i 's/127.0.0.1/$(DOCKER_DB)/g' .env

## —— 🧹 Clean ——
clean: ## Clean cache, logs, sessions
	$(RM) var/cache/* var/logs/* var/sessions/*

clean-all: ## Clean everything (cache, logs, sessions, vendor, node_modules, .env.local)
	$(RM) var/cache/* var/logs/* var/sessions/* vendor node_modules .env.local

## —— 🛠️  Others ——
help: ## List of commands
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'