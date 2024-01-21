# Custom WordPress container image
# This will setup and configure the latest wordpress + latest version of php-fpm 
FROM alpine:latest

# Adding "edge" repository where php-fpm is located !!!
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# Install packages for wordpress and php-fpm
RUN apk update && apk add --no-cache \
	curl \
	mariadb-client \
	php \
	php-fpm \
	php-mysqli \
	php-gd \
	php-curl \
	php-zip \
	php-xml \
	php-mbstring \
	php-json \
	php-intl \
	php-dom \
	php-phar \
	php-session

# !!! ATTENTION. Exact location for PHP config files based on its version !!!
# In `php-fpm.conf` line 17 and the very last line must contain the correct paths !
COPY ./tools/php-fpm.conf /etc/php82/php-fpm.conf
COPY ./tools/www.conf  /etc/php82/php-fpm.d/www.conf

COPY ./tools/config_wordpress.sh /tmp/

# EXPOSE 9000

ENTRYPOINT ["sh", "/tmp/config_wordpress.sh"]
