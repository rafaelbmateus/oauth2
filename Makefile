.PHONY: start
start: ##@docker build and up the docker compose in daemon
	docker-compose up --build -d

.PHONY: stop
stop: ##@docker stop the docker compose
	docker-compose stop

.PHONY: logs
logs: ##@docker show the last 100 lines
	docker-compose logs -f --tail=300

# ------------------- make help -------------------
.DEFAULT_GOAL := help

GREEN  := $(shell tput -Txterm setaf 2)
WHITE  := $(shell tput -Txterm setaf 7)
YELLOW := $(shell tput -Txterm setaf 3)
RESET  := $(shell tput -Txterm sgr0)
HELP_FUN = \
	%help; \
	while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^([a-zA-Z\-]+)\s*:.*\#\#(?:@([a-zA-Z\-]+))?\s(.*)$$/ }; \
	print "Usage: make [target]\n\n"; \
	for (sort keys %help) { \
	   print "${WHITE}$$_:${RESET}\n"; \
	   for (@{$$help{$$_}}) { \
		   $$sep = " " x (32 - length $$_->[0]); \
		   print "  ${YELLOW}$$_->[0]${RESET}$$sep${GREEN}$$_->[1]${RESET}\n"; \
	   }; \
	   print "\n"; \
	}

.PHONY: help
help: ##@other Show this help
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)
