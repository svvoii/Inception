## MariaDB Container

```bash
## after running the container, run the following commands
#
docker exec -it mariadb /bin/sh

mysql -u root -p` (or `mysql -u root -p${MARIADB_ROOT_PASSWORD}
# or
mysql -u ${MARIADB_USER} -p${MARIADB_PASSWORD}

# to show users
SELECT user, host FROM mysql.user;

# to show databases
show databases;
USE wordpress; 
# or
USE ${MARIADB_NAME}; # name of the database

show tables;
# to show the content of a table
SELECT * FROM <table_name>;
SELECT * FROM <table_name> WHERE <column_name> = <value>;
SELECT * FROM <table_name> limit 10;

# shows the privileges of the user
SHOW GRANTS FOR 'sbocanci'@'%'; # (sbocanci is the user)

# creates a new table
CREATE TABLE test_table (id INT, data VARCHAR(100));
INSERT INTO test_table VALUES (1, 'Hello World');
SELECT * FROM test_table;
 
# TO MAKE THE CHANGES TO THE DATABASE FROM PHPMYADMIN:
docker run --rm --name phpmyadmin -d --link mariadb-the-one -p 8081:80 -e PMA_HOST=db -e MYSQL_ROOT_PASSWORD=root phpmyadmin/phpmyadmin

```


## Wordpress Container

```bash
# Log inside the container
docker exec -it wordpress-the-one /bin/sh

# Ping the mariadb container from the wordpress container to check the connection
ping mariadb-the-one

# To test access to the mariadb container from the wordpress container
mysql -h mariadb-the-one -u ${MARIADB_USER} -p${MARIADB_PASSWORD} -D ${MARIADB_NAME}

# To check if user has necessary privileges
SHOW GRANTS FOR 'sbocanci'@'%';

```


## NGINX Container

```bash
docker exec -it nginx-the-one /bin/sh

# inside container
curl http://localhost:8080

# to see if there are any errors:
cat /var/log/nginx/error.log
```
## OTHER COMMANDS

```bash
# inspect the network...
docker network inspect <network_name>
```