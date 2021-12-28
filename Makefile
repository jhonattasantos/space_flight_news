DC = $(shell which docker-compose)

all: help

help:
	@echo "Available make commands:"
	@echo "  build           - build docker images for development"
	@echo "  dev             - up docker compose with logs"
	@echo "  down            - remove containers for services defined in the Compose file"
	@echo "  db-create       - create database based in config/database.yml file"
	@echo "  db-migrate      - migrations to database"
	@echo "  create-api      - create api project with postgresql database"

ps:
	${DC} ps

bash:
	${DC} exec space-rails-api bash

build:
	${DC} build --no-cache

dev:
	${DC} up -d space-rails-api space-queue

pub:
	${DC} up -d space-publisher-app

sub:
	${DC} up -d space-subscriber-app

down:
	${DC} down --remove-orphans 

db-create:
	${DC} exec space-rails-api bin/rails db:create db:migrate

db-migrate:
	${DC} exec space-rails-api bin/rails db:migrate

db-drop:
	${DC} exec space-rails-api bin/rails db:drop

create-api:
	${DC} run --no-deps space-rails-api rails new . --api --force --database=postgresql
