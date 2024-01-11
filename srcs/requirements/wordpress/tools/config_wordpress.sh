#!/bin/sh
echo "..Running config_wordpress.sh.."

# Waitin for mysql to start first
# pings <database-container-name> (mariadb-the-one) container for live status check
while ! mysqladmin ping -h ${MARIADB_HOSTNAME} --silent; do
	echo "Waiting for mysql to start..."
	sleep 1
done

# Waitin for ${MARIADB_DB_NAME} database to be created
while ! mysql -h ${MARIADB_HOSTNAME} -u ${MARIADB_USER} -p${MARIADB_PASSWORD} -e "use ${MARIADB_NAME}"; do
	echo "..waiting for "${MARIADB_DB_NAME}" database to be created..."
	sleep 1
done

# DEBUG
echo "..MariaDB is up and running!"

#
if [ ! -f "/var/www/html/index.html" ]; then

	mv /tmp/index.html /var/www/html/

	# Getting adminer.php
	curl -o /var/www/html/adminer.php https://www.adminer.org/static/download/4.8.1/adminer-4.8.1.php

	# Getting adminer.css
	curl -o /var/www/html/adminer.css https://raw.githubusercontent.com/vrana/adminer/master/designs/hever/adminer.css

	# Setting up wordpress
	wp core download --allow-root
	wp config create --allow-root --dbname=${MARIADB_NAME} --dbuser=${MARIADB_USER} --dbpass=${MARIADB_PASSWORD} --dbhost=${MARIADB_HOSTNAME} --dbcharset=utf8 --dbcollate=utf8_general_ci --skip-check
	wp core install --allow-root --url=${WP_URL}/wordpress --title=${WP_NAME} --admin_user=${WP_ADMIN_LOGIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --skip-email
	wp user create --allow-root ${WP_USER_LOGIN} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD} --role=author
	wp theme install --allow-root inspiro --activate

#	wp plugin update --allow-root --all

fi

# Make sure the www-data user and groop (for cgi-fpm) exists
if [ ! "$(getent passwd www-data)" ]; then
	addgroup -S -g 82 www-data
	adduser -u 82 -D -S -G www-data www-data
fi

echo "..starting wordpress and php-fpm7, port:9000."
# Starting php-fpm
/usr/sbin/php-fpm7 -F -R

