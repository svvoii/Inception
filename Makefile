# ADDING SOME COLORS
GREEN = \033[0;32m
RED = \033[0;31m
MAGENTA = \033[0;35m
CYAN = \033[0;36m
NC = \033[0m

build:
	mkdir -p /home/$(USER)/data/wordpress_data
	mkdir -p /home/$(USER)/data/mariadb_data
	docker compose -f srcs/docker-compose.yml build

up:
	docker compose -f srcs/docker-compose.yml up -d

down:
	docker compose -f srcs/docker-compose.yml down --volumes
	
fclean:
	sudo rm -fr /home/$(USER)/data/wordpress_data
	sudo rm -fr /home/$(USER)/data/mariadb_data
	docker system prune --all --force
#	docker volume prune --force

ls:
	@echo "$(CYAN)Docker images:$(NC)" && docker images
	@echo "$(CYAN)Running containers:$(NC)" && docker ps
	@echo "$(CYAN)All containers:$(NC)" && docker ps -a
	@echo "$(CYAN)Volumes:$(NC)" && docker volume ls
	@echo "$(CYAN)Networks:$(NC)" && docker network ls

logs:
	docker compose -f srcs/docker-compose.yml logs -f

.PHONY: build up down fclean ls logs
