
Ubuntu, php7-fpm and Nginx
================================


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