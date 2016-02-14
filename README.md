
Ubuntu, php7-fpm and Nginx
================================

Configure your dns in file `resolv.conf` before build, default is:

    nameserver 8.8.8.8

------------------

Xdebug is disabled by default, by questions of performance when executing `composer`, for enable xdebug only execute
one alias created on build, `php_xdebug` ,for example when execute your tests with `phpunit`, because is necessary for 
to generate your tests coverage.

    php_xdebug vendor/bin/phpunit

------------------


__To build execute:__
```
docker build -t php:7.0 .
```


__Lauching a container from your new image:__
```
docker run -d -P --name php7-nginx php:7.0
```


__Binding to a specific port:__
```
docker run -d -p 8080:80 --name php7-nginx php:7.0
```


__Bind mount a volume:__
```
docker run -d -v /home/user/workspaces/app/:/var/www php:7.0
```


__Access a shell:__
```
docker run -it --name php-nginx-cli php:7.0 /bin/bash
```

-------


#### CHANGELOG

[Link](https://github.com/luk4z7/docker-build-php7-fpm-nginx/blob/master/CHANGELOG.md)
