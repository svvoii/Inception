FROM alpine:3.18

RUN apk update && apk add --no-cache nginx openssl

RUN mkdir -p /var/www/html /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/sbocanci.42.fr.key \
	-out /etc/nginx/ssl/sbocanci.42.fr.crt \
	-subj "/C=FR/ST=France/L=Paris/O=42Paris/OU=sbocanci/CN=localhost"

COPY ./tools/nginx.conf /etc/nginx/nginx.conf

# This shall grant the user nginx to access the /var/www/html folder
RUN chown -R nginx:nginx /var/www/html /etc/nginx/ssl
USER nginx

CMD ["nginx", "-g", "daemon off;"]

# SOME DEBUG COMMANDS INSIDE THE CONTAINER
#
# cat /var/log/nginx/error.log
# 