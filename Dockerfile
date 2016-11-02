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

COPY ./include/pcapi /var/www/pcapienv

RUN	cd /var/www && \
	virtualenv pcapienv && \
	cd pcapienv && \
	. bin/activate && \
	pip install -e . && \
	chown -R www-data:www-data /var/www

# survey-designer related
COPY ./include/survey-designer /var/www/survey-designer

RUN apt-get -y install build-essential \
	libssl-dev \
	curl \
	libfontconfig && \
	curl https://raw.githubusercontent.com/creationix/nvm/v0.25.0/install.sh | bash

RUN . ~/.bashrc && \
	nvm install 4.0 && \
	nvm alias default v4.0

RUN . ~/.bashrc && \
	cd /var/www/survey-designer && \
	npm install jspm@0.16.42 && \
	npm install

#RUN . ~/.bashrc && \
#	cd /var/www/survey-designer && \
#	./node_modules/jspm/jspm.js install -y && \
#	npm run bundle

# survey-preview related
COPY ./include/survey-preview /var/www/survey-preview

RUN . ~/.bashrc && \
	cd /var/www/survey-preview && \
	npm install && \
	npm run bundle

# survey-viewer related
COPY ./include/fieldtrip-viewer /var/www/fieldtrip-viewer

COPY ./config_files/000-default.conf /etc/apache2/sites-available

# Upload an example survey
COPY ./include/survey_test.json /var/www

RUN apt-get install -y curl

RUN service apache2 start && \
	cd /var/www && \
	curl -v -H "Content-Type: application/json" -X PUT --data-binary "@survey_test.json" http://0.0.0.0/1.3/pcapi/editors/local/00000000-0000-0000-0000-000000000000/survey_test.json

# When the container is initialised
CMD /usr/sbin/apache2ctl -D FOREGROUND