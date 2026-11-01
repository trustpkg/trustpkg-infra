.PHONY: init
init:
	bash scripts/init.sh

.PHONY: help
help:
	@echo "Available commands:"
	@echo "make init                     - Initialize the project and install git hooks"