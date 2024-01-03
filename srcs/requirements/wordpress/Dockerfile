# This will setup and configure the wordpress + php-fpm container
# alpine 3.14 was the last version to comtain the PHP packages in its main repository..
FROM alpine:lastest

# Install packages for wordpress and php-fpm
RUN apk update && apk add \
	php7-fpm \
	php7-mysqli \
	php7-json \
	php7-openssl \
	php7-curl \
	php7-zlib \
	php7-xml \
	php7-phar \
	php7-intl \
	php7-dom \
	php7-xmlreader \
	php7-ctype \
	php7-session \
	php7-mbstring \
	--no-cache gettext \
	curl

# EXPOSE 9000

COPY ./tools/www.conf /var/www/html/
COPY ./tools/wp-config-template.php /var/www/html/
COPY ./tools/wordpress_entrypoint.sh /usr/local/bin

RUN mkdir -p /run/php

# Set the entrypoint / startup script
ENTRYPOINT ["wordpress_entrypoint.sh"]

WORKDIR /var/www/html/

CMD ["/usr/sbin/php-fpm7", "-F"]
