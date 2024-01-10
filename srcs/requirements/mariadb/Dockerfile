FROM alpine:3.18

RUN apk update && apk add --no-cache \
	mariadb \
	mariadb-client

COPY ./tools/config_mariadb.sh /tmp/

ENTRYPOINT ["sh", "/tmp/config_mariadb.sh"]
