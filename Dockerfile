FROM ubuntu:16.04

MAINTAINER Jose Lloret - jose.lloret@ed.ac.uk

# http related
RUN apt-get update && \
	apt-get -y install apache2 && \
	a2enmod headers

EXPOSE 80

# python related
RUN apt-get install -y \
			python-pip	\
			libapache2-mod-wsgi
# PCAPI related
RUN apt-get install -y \
			git \
			libpq-dev \
			libsqlite3-dev && \
	pip install --upgrade pip && \
	pip install virtualenv

COPY ./pcapi /var/www/pcapienv

RUN	cd /var/www && \
	virtualenv pcapienv && \
	cd pcapienv && \
	. bin/activate && \
	pip install -e . && \
	chown -R www-data:www-data /var/www

COPY ./000-default.conf /etc/apache2/sites-available

CMD /usr/sbin/apache2ctl -D FOREGROUND