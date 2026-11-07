.PHONY: init
init:
	bash scripts/init.sh

.PHONY: use-staging-env
use-staging-env:
	@echo "Run in your current shell: source scripts/use-env.sh terraform/environments/staging/.env"

.PHONY: help
help:
	@echo "Available commands:"
	@echo "make init                     - Initialize the project and install git hooks"
	@echo "make use-staging-env          - Show how to load staging environment variables"