FROM alpine:latest

LABEL maintainer=root@memogarcia.mx

RUN apk update && apk add mariadb mariadb-client

EXPOSE 3306

VOLUME /var/lib/mysql /var/log/mysql

COPY config/* /etc/mysql/

ENTRYPOINT ["mysqld_safe"]