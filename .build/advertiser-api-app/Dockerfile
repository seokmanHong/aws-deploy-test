FROM php:8.0.5-apache
ENV TZ="/usr/share/zoneinfo/Asia/Seoul"
ARG PROJECT_DIRECTORY=/web/app

###############################################################################
# before setup
###############################################################################
RUN apt-get update

###############################################################################
# default modules
###############################################################################
RUN apt-get install -y dos2unix \
    git \
    libpcre3-dev \
    libxml2-dev \
    libzip-dev \
    supervisor

###############################################################################
# for docker-php-ext-install
###############################################################################
RUN docker-php-ext-install zip pdo pdo_mysql bcmath sockets intl

###############################################################################
# install composer
###############################################################################
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

###############################################################################
# install bcmath
###############################################################################
#RUN docker-php-ext-configure bcmath
#RUN docker-php-ext-install bcmath

###############################################################################
# install gd with jpeg
###############################################################################
RUN apt-get update
RUN apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev
#RUN docker-php-ext-install -j$(nproc) iconv
RUN docker-php-ext-install -j$(nproc) gd

###############################################################################
# install intl for globalization
###############################################################################
#RUN docker-php-ext-configure intl
#RUN docker-php-ext-install intl

###############################################################################
# install redis
###############################################################################
RUN pecl install redis && docker-php-ext-enable redis

###############################################################################
# configure supervisor
###############################################################################
#RUN apt-get update
#RUN apt-get install -y supervisor
COPY supervisor.laravel.conf /etc/supervisor/conf.d/supervisor.laravel.conf

###############################################################################
# to prevent window crlf error
###############################################################################
#RUN apt-get install -y dos2unix

###############################################################################
# configure apache
###############################################################################
COPY site.conf /etc/apache2/sites-available/site.conf
RUN a2dissite 000-default.conf && a2ensite site.conf
RUN a2enmod rewrite

###############################################################################
# configure php
###############################################################################
COPY php.ini /usr/local/etc/php/php.ini

###############################################################################
# install dependencies via composer
###############################################################################
WORKDIR $PROJECT_DIRECTORY
COPY composer.json $PROJECT_DIRECTORY/composer.json
COPY composer.lock $PROJECT_DIRECTORY/composer.lock
RUN composer config -g repos.packagist composer https://packagist.kr
RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist

###############################################################################
# ADD PROEJCT FILES
###############################################################################
COPY --chown=www-data:www-data . $PROJECT_DIRECTORY

RUN mkdir -p $PROJECT_DIRECTORY/public
VOLUME $PROJECT_DIRECTORY

COPY start.sh /usr/local/bin/start

###############################################################################
# Before run sh, change its crlf to lf
###############################################################################
RUN dos2unix /usr/local/bin/start

RUN chmod u+x /usr/local/bin/start
CMD ["/usr/local/bin/start"]

EXPOSE 80
