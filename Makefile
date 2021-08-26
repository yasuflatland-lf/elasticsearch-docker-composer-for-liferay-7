# Cleanup database
.PHONY: clean
clean: ## Cleanup Environment
	rm -fR ./es/data

.PHONY: run
run: ## Run docker-compose
	docker-compose up --build

.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'