ARG NGINX_VERSION
FROM nginx:${NGINX_VERSION}
MAINTAINER EXCEEDWEB <excedweb@gmail.com>

ARG BUILD_ROOT_DIR=.build/advertiser-api/nginx
ARG PROJECT_DIRECTORY=/www_root/app
ARG ARG_PHP_FPM_CONTAINER
ARG ARG_PHP_FPM_PORT
ARG APP_ENV

COPY $BUILD_ROOT_DIR/nginx.conf /etc/nginx/
COPY $BUILD_ROOT_DIR/php-fpm.conf /etc/nginx/
COPY $BUILD_ROOT_DIR/proxy.conf /etc/nginx/
COPY $BUILD_ROOT_DIR/default.conf /etc/nginx/conf.d/

RUN sed -i "s/_PHP_FPM_CONTAINER_/$ARG_PHP_FPM_CONTAINER/g" /etc/nginx/php-fpm.conf
RUN sed -i "s/_PHP_FPM_PORT_/$ARG_PHP_FPM_PORT/g" /etc/nginx/php-fpm.conf
RUN cat /etc/nginx/php-fpm.conf
RUN find /etc/nginx -type f -exec chmod 0644 {} \; && mkdir -p $PROJECT_DIRECTORY/public

COPY --chown=www-data:www-data . $PROJECT_DIRECTORY
COPY .build/.env.$APP_ENV $PROJECT_DIRECTORY/.env

RUN chmod 755 $PROJECT_DIRECTORY/public

VOLUME $PROJECT_DIRECTORY
WORKDIR $PROJECT_DIRECTORY
