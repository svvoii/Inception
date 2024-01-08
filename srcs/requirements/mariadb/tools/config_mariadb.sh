#!bin/sh

chown -R mysql:mysql /var/lib/mysql /run/mysqld

# if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
# 	mysql_install_db --user=mysql --datadir=/var/lib/mysql
# 	mysqld --user=mysql --bootstrap --verbose=0 < /tmp/mysql-init.sql
# 	mysql -u root -e "CREATE DATABASE ${DB_NAME};"
# 	mysql -u root -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
# 	mysql -u root -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
# 	mysql -u root -e "FLUSH PRIVILEGES;"
# 	mysql -u root -e "EXIT;"
# fi

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then 

	cat << EOF > /tmp/mysql-init.sql
		USE mysql;
		FLUSH PRIVILEGES;
		DELETE FROM mysql.user WHERE User='';
		DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1`);
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
		CREATE DATABASE ${MYSQL_DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;
		CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
		GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
		FLUSH PRIVILEGES;
		EOF
	mariadb --user=mysql --bootstrap --verbose=0 < /tmp/mysql-init.sql

else
	echo "Database already exists"
fi

exec mariadb --user=mysql --bind-address=0.0.0.0
