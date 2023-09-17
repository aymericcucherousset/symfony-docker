## —— 🔥 App ——
init: ## Init the project
	$(MAKE) start
	$(MAKE) composer-install
	# $(MAKE) build-jwt-keys
	@$(call GREEN,"The application is available at: http://localhost:8000.")

new-app: ## Create a new Symfony application
	$(MAKE) down
	$(MAKE) start-dev-build
	$(MAKE) remove-app
	$(MAKE) config-git
	$(EXEC_WITHOUT_APP_PATH) symfony new $(APP_FOLDER) --webapp
	$(MAKE) composer-install
	$(MAKE) composer-require symfony/webpack-encore-bundle
	$(MAKE) npm-install
	$(MAKE) npm-add-defaults-scripts
	$(MAKE) npm-build
	@$(call GREEN,"Change the database host in DATABASE_URL in the .env file by $(DOCKER_DB).")

new-api: ## Create a new Symfony API application
	$(MAKE) down
	$(MAKE) start-dev-build
	$(MAKE) remove-app
	$(EXEC_WITHOUT_APP_PATH) symfony new $(APP_FOLDER) --no-git
	$(MAKE) composer-install

cache-clear: ## Clear cache
	$(SYMFONY_CONSOLE) cache:clear

build-jwt-keys: ## Build JWT keys
	$(SYMFONY_CONSOLE) lexik:jwt:generate-keypair --no-interaction --overwrite

shell: ## Open a shell in the container
	$(DOCKER) exec -it $(DOCKER_APP) /bin/bash

remove-app: ## Remove the app
	$(EXEC) $(RM) $(APP_FOLDER)

app: ## Command of the app container
	$(SYMFONY_CONSOLE) $(filter-out $@,$(MAKECMDGOALS))