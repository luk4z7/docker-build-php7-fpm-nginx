
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
RUN PPAPHP7=" ppa:ondrej/php" && \
    export LC_ALL=en_US.UTF-8 && \
    export LANG=en_US.UTF-8 && \
    add-apt-repository $PPAPHP7

RUN apt-get update

# Install libs and dependency's
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes \
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
    librecode-dev \
    snmp

# Install PHP7 and Nginx
RUN apt-get install -y --force-yes \
    php7.0 \
    php7.0-cgi \
    php7.0-fpm \
    php7.0-cli \
    php7.0-xsl \
    php7.0-common \
    php7.0-json \
    php7.0-opcache \
    php7.0-mysql \
    php7.0-phpdbg \
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

# DNS
ADD resolv.conf /etc/resolv.conf

# Xdebug
RUN wget https://xdebug.org/files/xdebug-2.4.0rc4.tgz
RUN tar xzvf xdebug-2.4.0rc4.tgz
RUN cd xdebug-2.4.0RC4 && phpize
RUN cd xdebug-2.4.0RC4 && chmod u+x ./configure
RUN cd xdebug-2.4.0RC4 && ./configure && make && make install
RUN cp /xdebug-2.4.0RC4/modules/xdebug.so $(php -i | grep extension | awk -F "=> " '{ print $3,$9 }')
RUN echo "alias php_xdebug='php -dzend_extension=xdebug.so'" >> ~/.bashrc

# phpunit
RUN wget https://phar.phpunit.de/phpunit.phar
RUN chmod +x phpunit.phar
RUN sudo mv phpunit.phar /usr/local/bin/phpunit
RUN phpunit --version

# Install composer
RUN wget https://getcomposer.org/download/1.0.0-alpha11/composer.phar
RUN chmod +x composer.phar
RUN sudo mv composer.phar /usr/local/bin/composer

# Install libs/var_dumper
RUN composer global require symfony/var-dumper

RUN cd $( php -i | grep php.ini | awk -F "=> " '{ print $2,$9 }') && PHPINI=$( pwd )/php.ini \
    && sed -i '660s/auto_prepend_file =/ /g' $PHPINI \
    && sed -i '660a auto_prepend_file = /root/.composer/vendor/autoload.php' $PHPINI

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

# Editing Nginx conf
RUN sed -i '16s/sendfile on;/sendfile off;/g' /etc/nginx/nginx.conf
RUN service nginx restart

# DocumentRoot
RUN mkdir -p /var/www
RUN mkdir -p /var/www/public

# Hello World
RUN echo "<?php phpinfo(); ?>" > /var/www/public/index.php

# Configure PATH
RUN export PATH=/usr/sbin:$PATH

# Export xterm for using commands with "clear"
RUN export TERM=xterm

# Execution shell on run container
CMD ["./build.sh"]

EXPOSE 80
