FROM nginx:latest
MAINTAINER EXCEEDWEB <excedweb@gmail.com>

ARG ARG_FPM_CONTAINER
ARG BUILD_ROOT_DIR=.build/advertiser-api/nginx

COPY $BUILD_ROOT_DIR/nginx.conf /etc/nginx/
COPY $BUILD_ROOT_DIR/php-fpm.conf /etc/nginx/
COPY $BUILD_ROOT_DIR/proxy.conf /etc/nginx/
COPY $BUILD_ROOT_DIR/default.conf /etc/nginx/conf.d/

#RUN sed -i "s/_PHP_FPM_CONTAINER_/127.0.0.1/g" /etc/nginx/php-fpm.conf
RUN cat /etc/nginx/php-fpm.conf
RUN find /etc/nginx -type f -exec chmod 0644 {} \; && mkdir -p /www_root/app/public

RUN chown www-data:www-data /www_root/app -R
RUN chmod 755 /www_root/app
RUN chmod 755 /www_root/app/public

VOLUME /www_root/app
WORKDIR /www_root/app
