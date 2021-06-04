FROM nginx:latest
MAINTAINER EXCEEDWEB <excedweb@gmail.com>

ARG BUILD_ROOT_DIR=.build/advertiser-api/nginx
ARG ARG_PHP_FPM_CONTAINER=127.0.0.1
ARG ARG_PHP_FPM_PORT=9000
ARG APP_ENV

COPY $BUILD_ROOT_DIR/nginx.conf /etc/nginx/
COPY $BUILD_ROOT_DIR/php-fpm.conf /etc/nginx/
COPY $BUILD_ROOT_DIR/proxy.conf /etc/nginx/
COPY $BUILD_ROOT_DIR/default.conf /etc/nginx/conf.d/

RUN sed -i "s/_PHP_FPM_CONTAINER_/$ARG_PHP_FPM_CONTAINER/g" /etc/nginx/php-fpm.conf
RUN sed -i "s/_PHP_FPM_PORT_/$ARG_PHP_FPM_PORT/g" /etc/nginx/php-fpm.conf
RUN cat /etc/nginx/php-fpm.conf
RUN find /etc/nginx -type f -exec chmod 0644 {} \; && mkdir -p /www_root/app/public

COPY . /www_root/app
COPY .build/.env.$ENV_APP_ENV /www_root/app/.env

RUN chown www-data:www-data /www_root/app -R
RUN chmod 755 /www_root/app/public

VOLUME /www_root/app
WORKDIR /www_root/app
