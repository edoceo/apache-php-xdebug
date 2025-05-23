#
# Edoceo Apache+PHP+Xdebug
#

FROM debian:12-slim

#
# Environment
ENV APACHE_SERVER_NAME="example.localhost"
ENV APACHE_SERVER_ROOT="/var/www/html"
ENV APACHE_LISTEN_PORT="*:80"
ENV XDEBUG_CLIENT_PORT="9003"


ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get --quiet --quiet --yes update \
	&& apt-get --quiet --quiet --yes upgrade \
	&& apt-get --quiet --quiet --yes install php-cli php-bcmath php-curl php-gd php-mbstring php-pear php-pgsql php-redis php-sqlite3 php-ssh2 php-xdebug php-xml php-yaml php-zip \
	&& apt-get --quiet --quiet --yes install libapache2-mod-php \
	&& phpenmod xdebug

#
# Install
COPY ./sysroot/apache2.conf /etc/apache2/apache2.conf
COPY ./sysroot/xdebug.ini /etc/php/8.2/mods-available/xdebug.ini

#COPY ./webroot/index.php /var/www/html/index.php
#COPY ./webroot/xdebug.php /var/www/html/xdebug.php
#COPY ./webroot/robots.txt /var/www/html/robots.txt
# COPY ./webroot/error.php /var/www/html/error.php

EXPOSE 80

ENTRYPOINT [ "/usr/sbin/apache2", "-DFOREGROUND" ]
