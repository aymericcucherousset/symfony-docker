## —— 📦 NPM ——
npm-install: ## Install dependencies according to the current package-lock.json file
	$(NPM) install $(filter-out $@,$(MAKECMDGOALS))

npm-i: ## Install dependencies according to the current package-lock.json file
	$(MAKE) npm-install $(filter-out $@,$(MAKECMDGOALS))

npm-update: ## Update dependencies according to the package.json file
	$(NPM) update

npm-u: ## Update dependencies according to the package.json file
	$(MAKE) npm-update

npm-build: ## Build the project
	$(NPM) run build

npm-b: ## Build the project
	$(MAKE) npm-build

npm-watch: ## Run the project in watch mode
	$(NPM) run watch

npm-w: ## Run the project in watch mode
	$(MAKE) npm-watch

npm-start: ## Run the project
	$(NPM) start

npm-s: ## Run the project
	$(MAKE) npm-start

npm-init: ## Init the project
	$(NPM) init

npm-require: ## Add a new dependency to the package.json file
	$(NPM) install $(filter-out $@,$(MAKECMDGOALS))

npm-require-dev: ## Add a new dev dependency to the package.json file
	$(NPM) install --save-dev $(filter-out $@,$(MAKECMDGOALS))

npm-remove: ## Remove a dependency from the package.json file
	$(NPM) uninstall $(filter-out $@,$(MAKECMDGOALS))

npm-add-defaults-scripts: ## Add default scripts to the package.json file
	sed -i 's/"test": "echo \\"Error: no test specified\\" && exit 1"/"dev-server": "encore dev-server",\n\t"dev": "encore dev",\n\t"watch": "encore dev --watch",\n\t"build": "encore production --progress",/g' app/package.json