
#
# Ubuntu, php7-fpm and Nginx

FROM ubuntu:trusty

MAINTAINER Lucas Alves "luk4z_7@hotmail.com"

RUN apt-get update

# Install tools
RUN apt-get install -y \
    python-setuptools \
    python-software-properties \
    software-properties-common \
    language-pack-en-base \
    wget \
    git \
    curl \
    zip \
    vim

# Add repository
RUN PPAPHP7=" ppa:ondrej/php-7.0" && export LC_ALL=en_US.UTF-8 && export LANG=en_US.UTF-8 && add-apt-repository $PPAPHP7

RUN apt-get update

# Install libs and dependency's
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libcurl4-openssl-dev \
    libmcrypt-dev \
    libxml2-dev \
    libjpeg-dev \
    libjpeg62 \
    libfreetype6-dev \
    libmysqlclient-dev \
    libt1-dev \
    libgmp-dev \
    libpspell-dev \
    libicu-dev \
    librecode-dev

# Install PHP7 and Nginx
RUN apt-get install -y \
    php7.0-fpm \
    php7.0-cli \
    php7.0-common \
    php7.0-json \
    php7.0-opcache \
    php7.0-mysql \
    php7.0-phpdbg \
    php7.0-dbg \
    php7.0-intl \
    php7.0-gd \
    php7.0-imap \
    php7.0-ldap \
    php7.0-pgsql \
    php7.0-pspell \
    php7.0-recode \
    php7.0-snmp \
    php7.0-tidy \
    php7.0-dev \
    php7.0-curl \
    nginx

# Install supervisor
RUN easy_install supervisor && \
    mkdir -p /var/log/supervisor && \
    mkdir -p /var/run/sshd && \
    mkdir -p /var/run/supervisord

# Add supervisord conf
ADD supervisord.conf /etc/supervisord.conf

# Create socker
RUN mkdir -p /run/php
RUN touch /run/php/php7.0-fpm.sock

# Shell
ADD build.sh /build.sh
RUN chmod 775 /build.sh

# VirtualHost
ADD ./default /etc/nginx/sites-available/default

# DocumentRoot
RUN mkdir -p /var/www
RUN mkdir -p /var/www/public

# Hello World
RUN echo "<?php phpinfo(); ?>" > /var/www/public/index.php

# Configure PATH
RUN export PATH=/usr/sbin:$PATH

# Execution shell on run container
CMD ["./build.sh"]

EXPOSE 80
