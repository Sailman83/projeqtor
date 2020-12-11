FROM php:7.4.13-apache

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

RUN apt-get install -y \
        libzip-dev \
        zip \
  && docker-php-ext-install zip
RUN docker-php-ext-configure gd --with-gd --with-webp --with-jpeg \
    --with-png --with-zlib --with-xpm --with-freetype \
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

RUN mkdir -p /parameter
RUN mkdir -p /log
RUN mkdir -p /report
RUN mkdir -p /attachment

RUN chown -R www-data:www-data /var/www/html/
RUN chown -R www-data:www-data /log
RUN chown -R www-data:www-data /report
RUN chown -R www-data:www-data /parameter
RUN chown -R www-data:www-data /attachment
