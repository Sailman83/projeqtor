FROM php:7.2-apache

ARG PROJEQTOR_LOG_PATH="${PROJEQTOR_LOG_PATH}"
ARG PROJEQTOR_CONFIG_PATH="${PROJEQTOR_CONFIG_PATH}"

ENV PROJEQTOR_LOG_PATH="${PROJEQTOR_LOG_PATH}"
ENV PROJEQTOR_CONFIG_PATH="${PROJEQTOR_CONFIG_PATH}"

RUN apt-get update -yqq && \
    apt-get install -yqq --no-install-recommends \
    apt-utils \
    libpq-dev \
    openssl \
    libzip-dev zip unzip \
    libc-client-dev libkrb5-dev \
    mariadb-client \
    libpng-dev \
    libldap2-dev \
    libwebp-dev libjpeg62-turbo-dev libpng-dev libxpm-dev \
    libfreetype6-dev


RUN docker-php-ext-configure zip --with-libzip=/usr/include
RUN docker-php-ext-install zip
RUN docker-php-ext-configure gd --with-gd --with-webp-dir --with-jpeg-dir \
    --with-png-dir --with-zlib-dir --with-xpm-dir --with-freetype-dir \
    --enable-gd-native-ttf
RUN docker-php-ext-install gd
RUN docker-php-ext-install pdo_mysql pdo_pgsql
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/
RUN docker-php-ext-install ldap
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install -j$(nproc) imap

ADD ./php/php.ini /usr/local/etc/php/php.ini
ADD ./apache/apache2.conf /etc/apache2/apache2.conf
ADD ./apache/000-default.conf /etc/apache2/sites-available/000-default.conf

COPY ./app/projeqtor /var/www/html/projeqtor/

RUN mkdir -p ${PROJEQTOR_LOG_PATH}
RUN mkdir -p ${PROJEQTOR_CONFIG_PATH}

RUN chown -R www-data:www-data /var/www/html/
RUN chown -R www-data:www-data ${PROJEQTOR_CONFIG_PATH}
RUN chown -R www-data:www-data ${PROJEQTOR_LOG_PATH}