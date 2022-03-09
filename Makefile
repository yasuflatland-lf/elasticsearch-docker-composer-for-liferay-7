.PHONY: clean
clean: ## Cleanup index
	rm -fR ./es/data
	mkdir ./es/data

.PHONY: destroy
destroy: ## Destroy all environment including IntelliJ metadata and libraries
	docker-compose down --rmi all --volumes --remove-orphans; \
	rm -fR ./es/data ./es/logs
	rm -fR .gradle
	rm -fR .idea

.PHONY: run
run: ## Shorthand of running docker images
	docker-compose up --build --remove-orphans

.PHONY: down
down: ## Stop Docker
	docker-compose down

.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
