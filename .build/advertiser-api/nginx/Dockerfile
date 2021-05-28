FROM nginx:latest
MAINTAINER EXCEEDWEB <excedweb@gmail.com>

ARG ARG_FPM_CONTAINER

COPY nginx.conf /etc/nginx/
COPY php-fpm.conf /etc/nginx/
COPY proxy.conf /etc/nginx/
COPY default.conf /etc/nginx/conf.d/

RUN sed -i "s/_PHP_FPM_CONTAINER_/$ARG_FPM_CONTAINER/g" /etc/nginx/php-fpm.conf
RUN cat /etc/nginx/php-fpm.conf
RUN find /etc/nginx -type f -exec chmod 0644 {} \; && mkdir -p /www_root/app/public

VOLUME /www_root/app
WORKDIR /www_root/app
