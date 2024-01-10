#!bin/sh
echo "..Inside MariaDB config script.."

chown -R mysql:mysql /var/lib/mysql /run/mysqld

# DEBUG PURPOSE
# echo "Database name: ${MARIADB_NAME}"
# echo "Database user: ${MARIADB_USER}"
# echo "Database password: ${MARIADB_PASSWORD}"
# echo "Database root password: ${MARIADB_ROOT_PASSWORD}"
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
