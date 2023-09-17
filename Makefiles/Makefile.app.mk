## —— 🔥 App ——
new-app: ## Create a new Symfony application
	$(MAKE) remove-app
	$(MAKE) down
	$(MAKE) start-dev-build
	$(MAKE) config-git
	$(EXEC_WITHOUT_APP_PATH) symfony new $(APP_FOLDER) --webapp
	$(MAKE) composer-install
	$(MAKE) composer-require symfony/webpack-encore-bundle
	$(MAKE) npm-install
	$(MAKE) npm-add-defaults-scripts
	$(MAKE) npm-build
	$(MAKE) configure-database-url
	@$(call RED,"Please change your credentials in the .env file.")
	@$(call GREEN,"The application is available at http://localhost:$(WEB_HTTP_SERVER_PORT).")

start-app: ## start the project
	$(MAKE) start
	$(MAKE) composer-install
	$(MAKE) npm-install
	@$(call GREEN,"The application is available at http://localhost:$(WEB_HTTP_SERVER_PORT).")

start-app-dev: ## start the project
	$(MAKE) start-dev-build
	$(MAKE) composer-install
	$(MAKE) npm-install
	@$(call GREEN,"The application is available at http://localhost:$(WEB_HTTP_SERVER_PORT).")

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
	$(MAKE) start
	$(EXEC_WITHOUT_APP_PATH) $(RM) $(APP_FOLDER)

app: ## Command of the app container
	$(SYMFONY_CONSOLE) $(filter-out $@,$(MAKECMDGOALS))