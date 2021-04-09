ARG  MYSQL_VERSION=latest
FROM mysql:${MYSQL_VERSION}

MAINTAINER EXCEEDWEB <exceedweb@gmail.com>

RUN cat /usr/share/zoneinfo/Asia/Seoul > /etc/localtime && \
    echo 'Asia/Seoul' >  /etc/timezone

COPY conf.d/my.cnf /etc/mysql/mysql.conf.d/
