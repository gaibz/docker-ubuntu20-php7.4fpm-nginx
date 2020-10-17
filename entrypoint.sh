#!/usr/bin/env bash

service nginx restart
service php7.4-fpm restart

tail -f /dev/null