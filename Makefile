# ADDING SOME COLORS
GREEN = \033[0;32m
RED = \033[0;31m
MAGENTA = \033[0;35m
CYAN = \033[0;36m
NC = \033[0m

#This will build the images only
build:
	docker compose -f srcs/docker-compose.yml build

#This will start the containers, create volumes and directories. Will also build the images if not yet exist
up:
	mkdir -p /home/$(USER)/data/wordpress_data
	mkdir -p /home/$(USER)/data/mariadb_data
	docker compose -f srcs/docker-compose.yml up -d

#This will stop and remove the containers only
down:
	docker compose -f srcs/docker-compose.yml down
	
#This removes all volumes and directories with data
clean: down
	docker compose -f srcs/docker-compose.yml down --volumes
	sudo rm -fr /home/$(USER)/data/wordpress_data
	sudo rm -fr /home/$(USER)/data/mariadb_data
#	docker volume ls -q | xargs docker volume rm --force

fclean: clean
	docker system prune --all --force

#This will show all images, containers, volumes and created networks
ls:
	@echo "$(MAGENTA)-> Docker images:$(NC)" && docker images
	@echo "$(MAGENTA)-> Running containers:$(NC)" && docker ps
#	@echo "$(MAGENTA)-> All containers:$(NC)" && docker ps -a
	@echo "$(MAGENTA)-> Volumes:$(NC)" && docker volume ls
	@echo "$(MAGENTA)-> Networks:$(NC)" && docker network ls | awk '$$2 !~ /^(bridge|host|none)$$/'

rebuild: fclean build

#This will show the logs of all containers (if any)
logs:
	docker compose -f srcs/docker-compose.yml logs

.PHONY: build up down fclean ls logs
