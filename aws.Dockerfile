# FROM php:8.0.5-apache
FROM 323538435273.dkr.ecr.ap-northeast-2.amazonaws.com/advertisement-api-app:latest

ENV TZ="/usr/share/zoneinfo/Asia/Seoul"

ARG PROJECT_DIRECTORY=/web/app

RUN apt-get update

###############################################################################
# INSTALLATIONS
# Docker의 캐시를 최대한 활용하기 위하여, 시간이 오래걸리는 설치류는 앞단으로 분리
###############################################################################
###############################################################################
# install php
###############################################################################
# for dev
RUN apt-get install -y net-tools vim iputils-ping

# for composer install/update
RUN apt-get install -y libpcre3-dev libzip-dev
RUN docker-php-ext-install zip

# for database connection
RUN docker-php-ext-install pdo pdo_mysql

# for googleads/googleads-php-lib
RUN apt-get install -y libxml2-dev
RUN docker-php-ext-install soap

###############################################################################
# install git(for composer install/update)
###############################################################################
# soap 설치 이후에 git을 찾지 못하는 현상이 발생하여 apt-get update 재수행
RUN apt-get update
RUN apt-get install -y git

###############################################################################
# install composer
###############################################################################
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

###############################################################################
# install image optimizers used on https://github.com/spatie/image-optimizer
###############################################################################
RUN apt-get install -y jpegoptim
RUN apt-get install -y optipng
RUN apt-get install -y pngquant
RUN apt-get install -y gifsicle

###############################################################################
# for window crlf
###############################################################################
RUN apt-get install -y dos2unix

###############################################################################
# install for using nslookup
###############################################################################
RUN apt-get install -y dnsutils

###############################################################################
# install bcmath for google-ads-php
###############################################################################
RUN docker-php-ext-configure bcmath
RUN docker-php-ext-install bcmath

###############################################################################
# install gd with jpeg
###############################################################################
#RUN apt-get install -y libpng-dev libjpeg62-turbo-dev
#RUN docker-php-ext-configure gd --with-jpeg
#RUN docker-php-ext-install gd

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-install -j$(nproc) gd

###############################################################################
# install intl for globalization
###############################################################################
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

###############################################################################
# install intl for video https://github.com/emgag/video-thumbnail-sprite
###############################################################################
RUN apt-get update
RUN apt-get install -y ffmpeg
RUN apt-get install -y imagemagick

###############################################################################
# install supervisor
###############################################################################
RUN apt-get update
RUN apt-get install -y supervisor

###############################################################################
# CONFIGURATIONS
###############################################################################
###############################################################################
# configure apache
###############################################################################
COPY site.conf /etc/apache2/sites-available/site.conf
RUN a2dissite 000-default.conf && a2ensite site.conf
RUN a2enmod rewrite

###############################################################################
# configure supervisor
###############################################################################
COPY supervisor.laravel.conf /etc/supervisor/conf.d/supervisor.laravel.conf

###############################################################################
# configure php
###############################################################################
COPY php.ini /usr/local/etc/php/php.ini

###############################################################################
# install dependencies via composer
###############################################################################
WORKDIR $PROJECT_DIRECTORY
# COPY composer.json $PROJECT_DIRECTORY/composer.json
# COPY composer.lock $PROJECT_DIRECTORY/composer.lock
# RUN composer install  --no-interaction
# RUN composer update  --no-interaction
# 먼가..컨테이너안에서 실행 안된다... 망할 개발자놈들
###############################################################################
# add proejct files
###############################################################################
COPY . $PROJECT_DIRECTORY

# permissions
RUN chown -R www-data:www-data .
#RUN chgrp -R www-data ./storage
#RUN chmod -R ug+rwx ./storage
#RUN chmod -R 0777 ./storage

COPY start.sh /usr/local/bin/start

###############################################################################
# Before run sh, change its crlf to lf
###############################################################################
RUN dos2unix /usr/local/bin/start

RUN chmod u+x /usr/local/bin/start
CMD ["/usr/local/bin/start"]

EXPOSE 80
