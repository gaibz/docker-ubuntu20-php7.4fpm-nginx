# Dockerize Ubuntu + Nginx + PHP7.4 FPM

This is just a base image for a project that require 

- Ubuntu 
- php7.4-fpm
- nginx

Personally for my own use case 

Github Repo : https://github.com/gaibz/docker-ubuntu20-php7.4fpm-nginx

Docker Repo : https://hub.docker.com/r/gaibz/ubuntu20-php7.4-nginx

# Setup & Build 

## Tag
```
gaibz/ubuntu20-php7.4-nginx:latest
```

## Nginx Server Config File

```
/etc/nginx/sites-enabled/*
```


## PHP Version : 7.4 (with default ubuntu repo)

default php-fpm is listen on 127.0.0.1:9000

fpm pool
```
/etc/php/7.4/fpm/pool.d/www.conf
```
fpm ini
```
/etc/php/7.4/fpm/php.ini
```


## app directory

```
/var/www/app
```

## Exposed Port

```
80/tcp
```

## What next ? 

- certbot