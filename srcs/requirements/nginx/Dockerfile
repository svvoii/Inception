# NGINX image
FROM alpine:3.18

RUN apk update && apk add --no-cache \
	nginx \
	openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/sbocanci.42.fr.key \
	-out /etc/nginx/ssl/sbocanci.42.fr.crt \
	-subj "/C=FR/ST=France/L=Paris/O=42Paris/OU=sbocanci/CN=localhost"

RUN mkdir -p /run/nginx

COPY ./tools/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]
