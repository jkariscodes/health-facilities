ifneq (,$(wildcard ./.env))
   include .env
   export
   ENV_FILE_PARAM = --env-file .env
endif

RED ?= \033[0;31m
GREEN ?= \033[0;32m
YELLOW ?= \033[0;33m
BLUE ?= \033[0;34m
PURPLE ?= \033[0;35m

.PHONY: all help build build-with-no-cache start-django start-django-detached shell django-shell stop-django delete-django-volumes makemigrations migrate create-superuser load-gis-data print-logs print-logs-interactive

help:
	@echo -e "\n$(WHITE)Available commands:$(COFF)"
	@echo -e "$(BLUE)make build$(COFF)                            - Builds or rebuilds services"
	@echo -e "$(BLUE)make build-with-no-cache$(COFF)              - Builds or rebuilds services with no cache"
	@echo -e "$(GREEN)make start-django$(COFF)                    - Starts Django service"
	@echo -e "$(GREEN)make start-django-detached$(COFF)           - Starts Django service in the background"
	@echo -e "$(PURPLE)make shell$(COFF)                          - Starts a Linux shell (bash) in the django container"
	@echo -e "$(PURPLE)make django-shell$(COFF)                   - Starts a django python shell in the django container"
	@echo -e "$(RED)make stop-django$(COFF)                       - Stops Django service"
	@echo -e "$(RED)make delete-django-volumes$(COFF)             - Deletes volumes associated with Django service"
	@echo -e "$(BLUE)make makemigrations$(COFF)                   - Runs Django's migrate command in the container"
	@echo -e "$(BLUE)make migrate$(COFF)                          - Runs Django's makemigrations command in the container"
	@echo -e "$(BLUE)make create-superuser$(COFF)                 - Runs Django's createsuperuser command in the container"
	@echo -e "$(BLUE)make load-gis-data$(COFF)                    - Populates PostGIS database with data"
	@echo -e "$(YELLOW)make print-logs$(COFF)                     - Prints logs on the shell"
	@echo -e "$(YELLOW)make print-logs-interactive$(COFF)         - Prints interactive logs on the shell"

build:
	@echo -e "$(BLUE)Building images:$(COFF)"
	@docker-compose build

build-with-no-cache:
	@echo -e "$(BLUE)Building images with no cache:$(COFF)"
	@docker-compose build --no-cache

start-services:
	@echo -e "$(GREEN)Starting Django backend service:$(COFF)"
	@docker-compose up

start-services-detached:
	@echo -e "$(GREEN)Starting Django backend service in the background:$(COFF)"
	@docker-compose up -d

shell:
	@echo -e "$(PURPLE)Starting Linux (Bash) shell in Django:$(COFF)"
	@docker-compose run --rm django bash

django-shell:
	@echo -e "$(PURPLE)Starting Django-Python shell:$(COFF)"
	@docker-compose run --rm django ./manage.py shell

stop-services:
	@echo -e "$(RED)Stopping Django backend service:$(COFF)"
	@docker-compose down

stop-delete-volumes:
	@echo -e "$(RED)Deleting volumes for Django and PostGIS:$(COFF)"
	@docker-compose down --volumes

makemigrations:
	@echo -e "$(BLUE)Make Django migrations:$(COFF)"
	@docker-compose run --rm django ./manage.py makemigrations $(cmd)

migrate:
	@echo -e "$(BLUE)Update database schema from Django migrations:$(COFF)"
	@docker-compose run --rm django ./manage.py migrate $(cmd)

create-superuser:
	@echo -e "$(BLUE)Create superuser for the backend admin:$(COFF)"
	@docker-compose run --rm django ./manage.py createsuperuser $(cmd)

load-facilities-data:
	@echo -e "$(BLUE)Populate DB with GIS data:$(COFF)"
	@docker-compose run --rm django python ./manage.py shell -c "from data import load_facilities;load_facilities.import_data()"

print-logs:
	@echo -e "$(YELLOW)Print out logs:$(COFF)"
	@docker-compose logs django$(cmd)

print-logs-interactive:
	@echo -e "$(YELLO)Print out logs:$(COFF)"
	@docker-compose logs --follow django $(cmd)