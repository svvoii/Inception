FROM alpine:3.18

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld /var/lib/mysql

RUN sed -i "s|skip-networking|#skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf

RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql
#	--skip-test-db

COPY ./tools/config_mariadb.sh /tmp/

RUN chmod +x /tmp/config_mariadb.sh

ENTRYPOINT ["/tmp/config_mariadb.sh"]
