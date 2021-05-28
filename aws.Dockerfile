ARG REPOSITORY=323538435273.dkr.ecr.ap-northeast-2.amazonaws.com/advertiser-api-app
ARG IMAGE_VERSION=latest
FROM $REPOSITORY:$IMAGE_VERSION

# ENV TZ="/usr/share/zoneinfo/Asia/Seoul"

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
RUN docker-php-ext-install bcmath \
    intl \
    pdo \
    pdo_mysql

###############################################################################
# INSTALL COMPOSER
###############################################################################
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
#COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

###############################################################################
# INSTALL IMAGE OPTIMIZERS USED ON https://github.com/spatie/image-optimizer
###############################################################################
RUN apt-get install -y jpegoptim optipng pngquant gifsicle

###############################################################################
# install bcmath
###############################################################################
#RUN docker-php-ext-configure bcmath
#RUN docker-php-ext-install bcmath

###############################################################################
# install gd with jpeg
###############################################################################
#RUN apt-get install -y libpng-dev libjpeg62-turbo-dev
#RUN docker-php-ext-configure gd --with-jpeg
#RUN docker-php-ext-install gd

RUN apt-get update && apt-get install -y \
        libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-install -j$(nproc) gd

###############################################################################
# install intl for globalization
###############################################################################
#RUN docker-php-ext-configure intl
#RUN docker-php-ext-install intl

###############################################################################
# install & configure supervisor
###############################################################################
#RUN apt-get update
#RUN apt-get install -y supervisor
COPY supervisor.laravel.conf /etc/supervisor/conf.d/supervisor.laravel.conf

###############################################################################
# configure apache
###############################################################################
COPY .build/advertiser-api-app/site.conf /etc/apache2/sites-available/site.conf
RUN a2dissite 000-default.conf && a2ensite site.conf
RUN a2enmod rewrite

###############################################################################
# configure php
###############################################################################
COPY .build/advertiser-api-app/php.ini /usr/local/etc/php/php.ini

###############################################################################
# install dependencies via composer
###############################################################################
WORKDIR $PROJECT_DIRECTORY
COPY .build/advertiser-api-app/composer.json $PROJECT_DIRECTORY/composer.json
COPY .build/advertiser-api-app/composer.lock $PROJECT_DIRECTORY/composer.lock
RUN composer config -g repos.packagist composer https://packagist.kr
RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist

###############################################################################
# add proejct files
###############################################################################
COPY --chown=www-data:www-data . $PROJECT_DIRECTORY
RUN mkdir -p $PROJECT_DIRECTORY/public
VOLUME $PROJECT_DIRECTORY

###############################################################################
# Before run sh, change its crlf to lf
###############################################################################
COPY .build/advertiser-api-app/start.sh /usr/local/bin/start
RUN dos2unix /usr/local/bin/start
RUN chmod u+x /usr/local/bin/start
CMD ["/usr/local/bin/start"]

EXPOSE 80
