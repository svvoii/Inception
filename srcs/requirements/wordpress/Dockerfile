# This will setup and configure the wordpress + php-fpm container
# alpine 3.14 was the last version to comtain the PHP packages in its main repository..
FROM alpine:3.14

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
	curl \
	mariadb-client

COPY ./tools/www.conf  /etc/php7/php-fpm.d/www.conf
COPY ./tools/wp-config-to-replace.php /var/www/html/
COPY ./tools/script-to-replace-wp-config.sh /var/www/html/

RUN mkdir -p /run/php

WORKDIR /var/www/html/

# Download and install wordpress. Extract the archive in the same `/var/www/html/` folder with `--strip-components=1` to avoid creating a subfolder
RUN curl -O https://wordpress.org/latest.tar.gz \
	&& tar -xvf latest.tar.gz --strip-components=1 \
	&& rm latest.tar.gz \
	&& sh script-to-replace-wp-config.sh

RUN if ! getent group www-data >/dev/null 2>&1; then addgroup -g 82 -S www-data; fi \
	&& if ! getent passwd www-data >/dev/null 2>&1; then adduser -u 82 -D -S -G www-data www-data; fi

# CMD ["/usr/sbin/php-fpm7", "-F"]
CMD ["php-fpm7", "-F"]
