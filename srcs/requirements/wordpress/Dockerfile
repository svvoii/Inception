# This will setup and configure the wordpress + php-fpm container
# alpine 3.14 was the last version to comtain the PHP packages in its main repository..
FROM alpine:3.14

# Install packages for wordpress and php-fpm
RUN apk update && apk upgrade && apk add \
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
	curl

WORKDIR /var/www/localhost/htdocs/

# Download and install wordpress
RUN curl -LO https://wordpress.org/latest.tar.gz \
	&& tar -xzf latest.tar.gz \
	&& rm -rf latest.tar.gz

WORKDIR /var/www/localhost/htdocs/wordpress

EXPOSE 9000

CMD ["php-fpm7", "-F"]
