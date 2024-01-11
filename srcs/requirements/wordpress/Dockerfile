# Wordpress image
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

# PHP configuration
RUN adduser -S nginx && addgroup -S nginx
COPY ./tools/php-fpm.conf /etc/php7/php-fpm.conf
COPY ./tools/www.conf  /etc/php7/php-fpm.d/www.conf

# Main webpage
COPY ./tools/index.html /tmp/

# Download and install wordpress. Extract the archive in the same `/var/www/html/` folder with `--strip-components=1` to avoid creating a subfolder
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/bin/wp

WORKDIR /var/www/html/wordpress

COPY ./tools/config_wordpress.sh /tmp/

ENTRYPOINT ["sh", "/tmp/config_wordpress.sh"]
