#!/bin/sh

if [ -f ./wordpress/wp-config.php ]; then
	echo "Wordpress already installed."
else
	echo "Wordpress not installed. Installing..."

	curl -LO https://wordpress.org/latest.tar.gz
	tar -xzf latest.tar.gz
	
	rm -fr latest.tar.gz
	rm -fr /etc/php/7.3/fpm/pool.d/www.conf
	mv ./www.conf /etc/php/7.3/fpm/pool.d/

	cd /var/www/html/wordpress
	envsubst < wp-config-template.php > wp-config-sample.php
	mv wp-config-sample.php wp-config.php

	echo "Wordpress installed."
fi
