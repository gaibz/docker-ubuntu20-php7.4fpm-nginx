# Dockerize Ubuntu + Nginx + PHP7.4 FPM

Docker Repo : 

# Setup & Build 

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