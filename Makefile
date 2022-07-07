include .env

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

SHELL := $(shell which bash)

.DEFAULT_GOAL := help

DOCKER := $(shell command -v docker)
DOCKER_COMPOSE := $(shell command -v docker-compose)
NPM := $(shell command -v npm)

.PHONY: help
help: 
	@egrep -h '^[a-zA-Z0-9_\/-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort -d | awk 'BEGIN {FS = ":.*?## "; printf "Usage: make \033[0;34mTARGET\033[0m \033[0;35m[ARGUMENTS]\033[0m\n\n"; printf "Targets:\n"}; {printf "  \033[33m%-25s\033[0m \033[0;32m%s\033[0m\n", $$1, $$2}'

deps:
ifndef DOCKER
	@echo "🐳 Docker não está instalado. Instale o docker."
	@exit 1
endif
ifndef DOCKER_COMPOSE
	@echo "🐳 docker-compose não está instalado. Instale docker-compose."
	@exit 1
endif
ifndef NPM
	@echo "usar npm para instalar dependencias"
endif
	@echo "Dependencias instaladas com sucesso"

%/dev: ENVIRONMENT = dev
%/prod: ENVIRONMENT = prod
build/%: TAG ?= $(ENVIRONMENT)

.PHONY: build/dev build/prod
build/dev: 
build/prod:
build/dev build/prod:
	@echo "Buildando projeto"
	@docker build --build-arg PORT=$(PORT) --target $(ENVIRONMENT) -t $(APP_NAME):$(TAG) -f ./docker/Dockerfile .

.PHONY: start/dev
start/dev: 
	@echo "Iniciar servidor em homologação"
	@docker-compose -f ./docker/docker-compose.$(ENVIRONMENT).yml --env-file .env up --build

.PHONY: start/prod
start/prod:
	@echo "Iniciar servidor em produção"
	@mkdir -p -m 755 ${LOGS_VOLUME}
	@docker-compose -f ./docker/docker-compose.$(ENVIRONMENT).yml --env-file .env up -d --build

.PHONY: start/db
start/db: 
	@echo "Iniciar banco de dados"
	@docker-compose -f ./docker/docker-compose.dev.yml --env-file .env up -d db adminer

PHONY: test/dev
test/dev: build/dev
	@echo "Testando projeto"
	@docker run --rm $(APP_NAME):$(ENVIRONMENT) npm run test:coverage

.PHONY: stop/dev stop/prod
stop/dev: 
stop/prod: 
stop/dev stop/prod:
	@echo "Parando docker"
	@docker-compose -f ./docker/docker-compose.$(ENVIRONMENT).yml --env-file .env down

.PHONY: stop/db
stop/db: ## Stop database container
	@echo "Pausando database"
	@docker-compose -f ./docker/docker-compose.dev.yml --env-file .env stop db adminer

.PHONY: clean/dev clean/prod
clean/dev: 
clean/prod:
clean/dev clean/prod:
	@echo "Excluindo recursos"
	@docker-compose -f ./docker/docker-compose.$(ENVIRONMENT).yml --env-file .env down --rmi local --volumes --remove-orphans

