## —— 📦 Composer ——
composer-install: ## Install vendors according to the current composer.lock file
	$(COMPOSER) install

composer-i: ## Install vendors according to the current composer.lock file
	$(MAKE) composer-install

composer-install-dev: ## Install vendors according to the current composer.lock file
	$(COMPOSER) install --dev

composer-update: ## Update vendors according to the composer.json file
	$(COMPOSER) update

composer-u: ## Update vendors according to the composer.json file
	$(MAKE) composer-update

composer-update-dev: ## Update vendors according to the composer.json file
	$(COMPOSER) update --dev

composer-require: ## Add a new vendor to the composer.json file
	$(COMPOSER) require $(filter-out $@,$(MAKECMDGOALS))
%:
	@:

composer-require-dev: ## Add a new dev vendor to the composer.json file
	$(COMPOSER) require --dev $(filter-out $@,$(MAKECMDGOALS))
%:
	@:

composer-remove: ## Remove a vendor from the composer.json file
	$(COMPOSER) remove $(filter-out $@,$(MAKECMDGOALS))
%:
	@: