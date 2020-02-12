NETWORK_NAME := sample_network

init:
	-docker network create $(NETWORK_NAME)
	docker-compose up --build --no-start
	docker-compose run --rm app bundle install
	docker-compose run --rm app bundle exec rails db:create db:migrate db:seed

ps: _docker_compose
start: _docker_compose
stop: _docker_compose
restart: _docker_compose

_docker_compose:
	@docker-compose $(MAKECMDGOALS)

bundle:
	@docker-compose run --rm app bundle install

migrate:
	@docker-compose run --rm app db:migrate

sh:
	@docker-compose exec app bash

logs:
	@docker-compose logs app

annotate:
	@docker-compose run --rm app bundle exec annotate --models

down:
	@docker-compose down
	@docker network remove $(NETWORK_NAME)

reinit:
	-docker-compose down
	docker network remove $(NETWORK_NAME)
	docker network create $(NETWORK_NAME)
	docker-compose up --build --no-start
	docker-compose run --rm app bundle install
	docker-compose run --rm app bundle exec rails db:drop db:create db:migrate db:seed
