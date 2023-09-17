
## —— 🚀 Symfony ——
sf-console: ## Run a Symfony console command
	$(SYMFONY_CONSOLE) $(filter-out $@,$(MAKECMDGOALS))
%:
	@:

sf: ## Run a Symfony command
	$(MAKE) sf-console $(filter-out $@,$(MAKECMDGOALS))
%:
	@:

console: ## Run a Symfony console command
	$(MAKE) sf-console $(filter-out $@,$(MAKECMDGOALS))
%:
	@:

sf-clear-cache: ## Clear cache
	$(SYMFONY_CONSOLE) cache:clear

sf-cc: ## Clear cache
	$(SYMFONY_CONSOLE) cache:clear

sf-create-database: ## Create database
	$(SYMFONY_CONSOLE) doctrine:database:create --if-not-exists

sf-drop-database: ## Drop database
	$(SYMFONY_CONSOLE) doctrine:database:drop --force --if-exists

sf-make-migration: ## Create a new migration based on database changes
	$(SYMFONY_CONSOLE) make:migration

sf-migrate: ## Execute migrations
	$(SYMFONY_CONSOLE) doctrine:migrations:migrate --no-interaction