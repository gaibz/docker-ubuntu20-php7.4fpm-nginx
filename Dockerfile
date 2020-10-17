# Using base ubuntu image
FROM ubuntu:20.04

LABEL Maintainer="Herlangga Sefani <herlanggasefani@gmail.com>" \
      Description="Nginx + PHP7.4-FPM Based on Ubuntu 20.04."

# Setup document root
RUN mkdir -p /var/www/app

# Base install
RUN apt update
RUN apt install curl gnupg2 ca-certificates lsb-release libicu-dev supervisor nginx -y

# Install php7.4-fpm
# Since the repo is supported on ubuntu 20
RUN apt install php-fpm php-json php-pdo php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath php-intl -y

# Install Nginx
# RUN echo "deb http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
#     | tee /etc/apt/sources.list.d/nginx.list

# RUN curl -fsSL https://nginx.org/keys/nginx_signing.key | apt-key add -
# RUN apt-key fingerprint ABF5BD827BD9BF62
# RUN apt update
# RUN apt install nginx -y

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