# Using base ubuntu image
FROM ubuntu:20.04

LABEL Maintainer="Herlangga Sefani <herlanggasefani@gmail.com>" \
      Description="Nginx + PHP7.4-FPM Based on Ubuntu 20.04."

# Setup document root
RUN mkdir -p /var/www/app

# Base install
RUN apt update --fix-missing
RUN apt install git zip unzip curl gnupg2 ca-certificates lsb-release libicu-dev supervisor nginx -y

# Install php7.4-fpm
# Since the repo is supported on ubuntu 20
RUN apt install php-fpm php-json php-pdo php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath php-intl -y

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"
# Check if installation successfull
RUN composer --help

COPY ./entrypoint.sh ./entrypoint.sh

RUN chmod +x ./entrypoint.sh

RUN rm /etc/nginx/sites-enabled/default

COPY ./php/php.ini /etc/php/7.4/fpm/php.ini
COPY ./php/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./nginx/server.conf /etc/nginx/sites-enabled/default.conf
COPY ./supervisor/config.conf /etc/supervisor/conf.d/supervisord.conf

# Starter file
COPY ./php/index.php /var/www/app/index.php


EXPOSE 80

# Let supervisord start nginx & php-fpm
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# # Prevent exit
# ENTRYPOINT ["./entrypoint.sh"]