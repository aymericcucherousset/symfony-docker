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