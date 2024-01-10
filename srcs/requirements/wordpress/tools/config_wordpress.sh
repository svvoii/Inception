#!/bin/sh
echo "..Running config_wordpress.sh.."

# Waitin for mysql to start first
while ! mysqladmin ping -h mysql --silent; do
	echo "Waiting for mysql to start..."
	sleep 1
done

#
if [ ! -f "/var/www/html/index.html" ]; then

	mv /tmp/index.html /var/www/html/

	# Getting adminer.php
	curl -o /var/www/html/adminer.php https://www.adminer.org/static/download/4.8.1/adminer-4.8.1.php

	# Getting adminer.css
	curl -o /var/www/html/adminer.css https://raw.githubusercontent.com/vrana/adminer/master/designs/hever/adminer.css

	# Setting up wordpress
	wp core download --allow-root
	wp config create --allow-root --dbname=${MARIADB_DB_NAME} --dbuser=${MARIADB_USER} --dbpass=${MARIADB_PASSWORD} --dbhost=${MARIADB_HOSTNAME} --dbcharset=utf8 --dbcollate=utf8_general_ci --skip-check
	wp core install --allow-root --url=${WP_URL}/wordpress --title=${WP_NAME} --admin_user=${WP_ADMIN_LOGIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --skip-email
	wp user create --allow-root ${WP_USER_LOGIN} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD} --role=author
	wp theme install --allow-root inspiro --activate

#	wp plugin update --allow-root --all

fi

# Starting php-fpm
/usr/sbin/php-fpm7 -F -R

echo "..Wordpress started, port:9000."
