# Mariadb image
FROM alpine:latest

RUN apk update && apk add --no-cache \
	mariadb \
	mariadb-client

COPY ./tools/config_mariadb.sh /tmp/

ENTRYPOINT ["sh", "/tmp/config_mariadb.sh"]

# EXPOSE 3306

CMD ["mariadbd", "--user=mysql"]
