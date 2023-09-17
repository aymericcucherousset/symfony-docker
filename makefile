# Variables
DOCKER = docker
DOCKER_COMPOSE = docker-compose
DOCKER_APP = template_app_sf # APP container name
EXEC = $(DOCKER) exec -w /var/www $(DOCKER_APP)
PHP = $(EXEC) php
COMPOSER = $(EXEC) composer
NPM = $(EXEC) npm
SYMFONY_CONSOLE = $(PHP) bin/console
RM = rm -rf

DOCKER_COMPOSE_FILE = docker-compose.yaml
DOCKER_COMPOSE_FILE_DEV = docker-compose.dev.yaml

# Colors
GREEN = /bin/echo -e "\x1b[32m\#\# $1\x1b[0m"
RED = /bin/echo -e "\x1b[31m\#\# $1\x1b[0m"

## —— 🔥 App ——
init: ## Init the project
	$(MAKE) start
	$(MAKE) composer-install
	# $(MAKE) build-jwt-keys
	@$(call GREEN,"The application is available at: http://localhost:8000.")

new-app: ## Create a new Symfony application
	$(EXEC) symfony new app --webapp

new-api: ## Create a new Symfony API application
	$(EXEC) symfony new app --no-git

cache-clear: ## Clear cache
	$(SYMFONY_CONSOLE) cache:clear

build-jwt-keys: ## Build JWT keys
	$(SYMFONY_CONSOLE) lexik:jwt:generate-keypair --no-interaction --overwrite

shell: ## Open a shell in the container
	$(DOCKER) exec -it $(DOCKER_APP) /bin/bash

remove-app: ## Remove the app
	$(RM) app

## —— 🐳 Docker ——
start: ## Start the project
	$(DOCKER_COMPOSE) up -d --remove-orphans

start-dev: ## Start the project in dev mode
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) -f $(DOCKER_COMPOSE_FILE_DEV) up -d --remove-orphans

start-dev-build: ## Start the project in dev mode and build images
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) -f $(DOCKER_COMPOSE_FILE_DEV) up -d --remove-orphans --build

stop: ## Stop the project
	$(DOCKER_COMPOSE) stop

down: ## Stop and remove the project containers
	$(DOCKER_COMPOSE) down --remove-orphans

restart: ## Restart the project
	$(MAKE) down
	$(MAKE) start

## —— 🧹 Clean ——

clean: ## Clean cache, logs, sessions
	$(RM) var/cache/* var/logs/* var/sessions/*

clean-all: ## Clean everything (cache, logs, sessions, vendor, node_modules, .env.local)
	$(RM) var/cache/* var/logs/* var/sessions/* vendor node_modules .env.local

## —— 📦 Composer ——

composer-install: ## Install vendors according to the current composer.lock file
	$(COMPOSER) install

composer-update: ## Update vendors according to the composer.json file
	$(COMPOSER) update

composer-require: ## Add a new vendor to the composer.json file
	$(COMPOSER) require $(filter-out $@,$(MAKECMDGOALS))

composer-require-dev: ## Add a new dev vendor to the composer.json file
	$(COMPOSER) require --dev $(filter-out $@,$(MAKECMDGOALS))

composer-remove: ## Remove a vendor from the composer.json file
	$(COMPOSER) remove $(filter-out $@,$(MAKECMDGOALS))

## —— 📦 NPM ——

npm-install: ## Install dependencies according to the current package-lock.json file
	$(NPM) install

npm-update: ## Update dependencies according to the package.json file
	$(NPM) update

npm-require: ## Add a new dependency to the package.json file
	$(NPM) install $(filter-out $@,$(MAKECMDGOALS))

npm-require-dev: ## Add a new dev dependency to the package.json file
	$(NPM) install --save-dev $(filter-out $@,$(MAKECMDGOALS))

npm-remove: ## Remove a dependency from the package.json file
	$(NPM) uninstall $(filter-out $@,$(MAKECMDGOALS))

