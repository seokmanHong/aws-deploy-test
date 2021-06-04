FROM php:8.0.6-fpm
MAINTAINER EXCEEDWEB <exceedweb@gmail.com>

ARG BUILD_ROOT_DIR=.build/advertiser-api/php-fpm
ARG PROJECT_DIRECTORY=/www_root/app
ARG ARG_PHP_FPM_PORT
ARG ARG_PHP_FPM_HOST
ARG APP_ENV

ENV DEBCONF_NOWARNINGS yes
ENV DEBIAN_FRONTEND noninteractive

###################################################################################
# Set timezone to Asia/Seoul
###################################################################################
RUN cat /usr/share/zoneinfo/Asia/Seoul > /etc/localtime && \
    echo 'Asia/Seoul' >  /etc/timezone

###################################################################################
# Configure php.ini
###################################################################################
RUN cp /usr/local/etc/php/php.ini-production \
    /usr/local/etc/php/php.ini && \
    sed -i -e 's|^[; ]*expose_php *=.*$|expose_php = Off|' \
        -e 's|^[; ]*post_max_size *=.*$|post_max_size = 50M|' \
        -e 's|^[; ]*upload_max_filesize *=.*$|upload_max_filesize = 50M|' \
        -e 's|^[; ]*memory_limit *=.*$|memory_limit = 2G|' \
        -e 's|^[; ]*phar\.readonly *=.*$|phar.readonly = Off|' \
        -e 's|^[; ]*date\.timezone *=.*$|date.timezone = Asia/Seoul|' \
        /usr/local/etc/php/php.ini

###################################################################################
# Default modules
###################################################################################
RUN apt-get update
RUN apt-get install -y dos2unix \
    git \
    libpcre3-dev \
    libxml2-dev \
    libzip-dev \
    supervisor

###################################################################################
# For docker-php-ext-install
###################################################################################
RUN docker-php-ext-install bcmath intl mysqli pdo pdo_mysql soap zip

###################################################################################
# Image handler
###################################################################################
RUN apt-get install -y libfreetype6-dev libpng-dev \
    libjpeg62-turbo-dev libxpm-dev libwebp-dev libzip-dev libxml2-dev
RUN apt-get install -y jpegoptim \
    optipng pngquant gifsicle imagemagick
RUN docker-php-ext-configure \
    gd --with-freetype --with-jpeg --with-xpm --with-webp && \
    docker-php-ext-install -j$(nproc) gd opcache && \
    docker-php-source delete

###################################################################################
# Redis igbinary
###################################################################################
RUN docker-php-source extract && \
    pecl bundle -d /usr/src/php/ext igbinary && \
    docker-php-ext-configure igbinary && \
    docker-php-ext-install -j$(nproc) igbinary && \
    docker-php-source delete
RUN docker-php-source extract && \
    pecl bundle -d /usr/src/php/ext msgpack && \
    docker-php-ext-configure msgpack && \
    docker-php-ext-install -j$(nproc) msgpack && \
    docker-php-source delete
RUN docker-php-source extract && \
    pecl bundle -d /usr/src/php/ext redis && \
    docker-php-ext-configure redis --enable-redis-igbinary \
    --enable-redis-msgpack --enable-redis-lzf && \
    docker-php-ext-install -j$(nproc) redis && docker-php-source delete
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

###################################################################################
# Copy everything necessary
###################################################################################
COPY $BUILD_ROOT_DIR/start.sh /usr/local/bin/start
COPY $BUILD_ROOT_DIR/www.conf /usr/local/etc/php-fpm.d/
RUN sed -i "s/_PHP_FPM_PORT_/$ARG_PHP_FPM_PORT/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/_PHP_FPM_HOST_/$ARG_PHP_FPM_HOST/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/9000/$ARG_PHP_FPM_PORT/g" /usr/local/etc/php-fpm.d/zz-docker.conf
RUN cat /usr/local/etc/php-fpm.d/www.conf

COPY $BUILD_ROOT_DIR/supervisor.laravel.conf \
    /etc/supervisor/conf.d/supervisor.laravel.conf
# COPY . $PROJECT_DIRECTORY

COPY .build/.env.$APP_ENV /www_root/app/.env
RUN cat /www_root/app/.env

RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/local/bin --filename=composer
ENV PATH="$PATH:/root/.composer/vendor/bin"

COPY --chown=www-data:www-data . $PROJECT_DIRECTORY
RUN mkdir -p $PROJECT_DIRECTORY/public

VOLUME $PROJECT_DIRECTORY
WORKDIR $PROJECT_DIRECTORY

###################################
# Command script
###################################
RUN dos2unix /usr/local/bin/start
RUN chmod u+x /usr/local/bin/start
CMD ["/usr/local/bin/start"]

