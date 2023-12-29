up:
	docker compose -f srcs/docker-compose.yml up -d

down:
	docker compose -f srcs/docker-compose.yml down

build:
	docker compose -f srcs/docker-compose.yml build

rebuild:
	docker compose -f srcs/docker-compose.yml down && docker compose -f path/to/docker-compose.yml build && docker compose -f path/to/docker-compose.yml up -d

logs:
	docker compose -f srcs/docker-compose.yml logs -f
