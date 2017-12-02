
# Ubuntu, php7-fpm and Nginx

### Getting started

Clone the repository in folder do you prefer
```bash
cd /var/www
git clone https://github.com/luk4z7/docker-build-php7-fpm-nginx
```

Configure your dns if necessary in file `resolv.conf` before build, default is:

```bash
nameserver 8.8.8.8
```

**Execute the file `init.sh` for up the docker containers**

```bash
https://github.com/luk4z7/docker-build-php7-fpm-nginx 
Environment Ubuntu, php7-fpm and nginx 
 
     _            _                  _           _ _     _ 
  __| | ___   ___| | _____ _ __     | |__  _   _(_) | __| |
 / _` |/ _ \ / __| |/ / _ \ '__|____| '_ \| | | | | |/ _` |
| (_| | (_) | (__|   <  __/ | |_____| |_) | |_| | | | (_| |
 \__,_|\___/ \___|_|\_\___|_|       |_.__/ \__,_|_|_|\__,_|
                                                           
php7, nginx 

DOCKER
Generate new containers ? [ 1 ] 
Delete all containers ?   [ 2 ] 
Start new build ?         [ 3 ]
```

First step
```bash
Start new build          [ 3 ]
```

Second step
```bash
Generate new containers  [ 1 ]
```

Access log of an single container
```bash
docker logs php7 -f
```

Xdebug is disabled by default, by questions of performance when executing `composer`, for enable xdebug only execute one alias created on build, `php_xdebug`, for example when execute your tests with `phpunit`, because is necessary for to generate your tests coverage.

```php
php_xdebug vendor/bin/phpunit
```

#### CHANGELOG

[Link](https://github.com/luk4z7/docker-build-php7-fpm-nginx/blob/master/CHANGELOG.md)
