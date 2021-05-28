FROM php:8.0.6-fpm
MAINTAINER EXCEEDWEB <exceedweb@gmail.com>

ARG ARG_PHP_FPM_PORT
ENV DEBCONF_NOWARNINGS yes
ENV DEBIAN_FRONTEND noninteractive

RUN cat /usr/share/zoneinfo/Asia/Seoul > /etc/localtime && \
    echo 'Asia/Seoul' >  /etc/timezone

RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini && \
    sed -i -e 's|^[; ]*expose_php *=.*$|expose_php = Off|' \
        -e 's|^[; ]*post_max_size *=.*$|post_max_size = 50M|' \
        -e 's|^[; ]*upload_max_filesize *=.*$|upload_max_filesize = 50M|' \
        -e 's|^[; ]*memory_limit *=.*$|memory_limit = 2G|' \
        -e 's|^[; ]*phar\.readonly *=.*$|phar.readonly = Off|' \
        -e 's|^[; ]*date\.timezone *=.*$|date.timezone = Asia/Seoul|' \
        /usr/local/etc/php/php.ini

#####################################################################
# default modules
#####################################################################
RUN apt-get update
RUN apt-get install -y dos2unix \
    git \
    libpcre3-dev \
    libxml2-dev \
    libzip-dev \
    supervisor

#####################################################################
# for docker-php-ext-install
#####################################################################
RUN docker-php-ext-install bcmath intl mysqli pdo pdo_mysql soap zip

#####################################################################
# for image
#####################################################################
RUN apt-get install -y libfreetype6-dev libpng-dev libjpeg62-turbo-dev \
    libxpm-dev libwebp-dev libzip-dev libxml2-dev
RUN apt-get install -y jpegoptim optipng pngquant gifsicle imagemagick
RUN docker-php-ext-configure \
    gd --with-freetype --with-jpeg --with-xpm --with-webp && \
    docker-php-ext-install -j$(nproc) gd opcache && \
    docker-php-source delete

#####################################################################
# redis igbinary
#####################################################################
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

COPY php-fpm/www.conf /usr/local/etc/php-fpm.d/

RUN sed -i "s/_PHP_FPM_PORT_/$ARG_PHP_FPM_PORT/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/9000/$ARG_PHP_FPM_PORT/g" /usr/local/etc/php-fpm.d/zz-docker.conf

######################### supervisor configuration #########################
COPY php-fpm/supervisor.laravel.conf /etc/supervisor/conf.d/supervisor.laravel.conf
############################################################################

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV PATH="$PATH:/root/.composer/vendor/bin"

RUN mkdir -p /www_root/app/public
VOLUME /www_root/app
WORKDIR /www_root/app

########## command script ##########
COPY php-fpm/start.sh /usr/local/bin/start
RUN dos2unix /usr/local/bin/start
RUN chmod u+x /usr/local/bin/start
CMD ["/usr/local/bin/start"]
####################################
