FROM alpine:3.18

RUN apk update && apk add --no-cache nginx openssl

RUN mkdir -p /run/nginx

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/sbocanci.42.fr.key \
	-out /etc/ssl/certs/sbocanci.42.fr.crt \
	-subj "/C=FR/ST=France/L=Paris/O=42Paris/OU=sbocanci/CN=localhost"

COPY ./tools/nginx.conf /etc/nginx/conf.d/default.conf

#EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
