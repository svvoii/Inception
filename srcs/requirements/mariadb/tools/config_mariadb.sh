#!bin/sh
echo "..Inside MariaDB config script.."

chown -R mysql:mysql /var/lib/mysql /run/mysqld

# DEBUG PURPOSE
echo "Database name: ${MARIADB_NAME}"
echo "Database user: ${MARIADB_USER}"
echo "Database password: ${MARIADB_PASSWORD}"
echo "Database root password: ${MARIADB_ROOT_PASSWORD}"
# # # #

create_database() {
	cat << EOF > /tmp/mysql-init.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MARIADB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MARIADB_NAME}.* TO '${MARIADB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

	mariadbd --user=mysql --bootstrap < /tmp/mysql-init.sql
}

if [ ! -d "/var/lib/mysql/${MARIADB_NAME}" ]; then 
	echo "Creating database"
	create_database
else
	echo "Database already exists"
fi

exec mariadbd --user=mysql --bind-address=0.0.0.0

# # # # TESTING MARIADB SETUP # # # #
## after running the container, run the following commands
#
# `docker exec -it mariadb /bin/sh`
# `mysql -u root -p` (or `mysql -u root -p${MARIADB_ROOT_PASSWORD}`)
# also `mysql -u ${MARIADB_USER} -p${MARIADB_PASSWORD}`
# `show databases;`
# `use wordpress;`
# `show tables;`
# `SHOW GRANTS FOR 'sbocanci'@'%';` (sbocanci is the user)
#
# `USE wordpress;` (or `USE ${MARIADB_NAME};`) name of the database
# `CREATE TABLE test_table (id INT, data VARCHAR(100));`
# `INSERT INTO test_table VALUES (1, 'Hello World');`
# `SELECT * FROM test_table;`
# 
## TO MAKE THE CHANGES TO THE DATABASE FROM PHPMYADMIN:
#
# docker run --rm --name phpmyadmin -d --link mariadb-the-one -p 8081:80 -e PMA_HOST=db -e MYSQL_ROOT_PASSWORD=root phpmyadmin/phpmyadmin
