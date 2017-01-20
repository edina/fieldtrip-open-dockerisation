FROM ubuntu:16.04

MAINTAINER Jose Lloret - jose.lloret@ed.ac.uk

# ARGs needed to build the image

ARG JSPM_GITHUB_AUTH
ARG GROUP=pcapi
ARG USER=pcapi
ARG USER_HOME=/home/${USER}
ARG UID=1000
ARG GID=1000

# Mapping ARG to ENV since these are used while running container

ENV GROUP ${GROUP}
ENV USER ${USER}
ENV USER_HOME ${USER_HOME}
ENV UID ${UID}
ENV GID ${GID}

# http related
RUN apt-get update && \
	apt-get -y install apache2 && \
	a2enmod headers

COPY ./config_files/000-default.conf /etc/apache2/sites-available

EXPOSE 80

# python related
RUN apt-get install -y \
			python-pip	\
			libapache2-mod-wsgi
# PCAPI related

RUN groupadd -g ${GID} ${GROUP} && useradd -d ${USER_HOME} -u ${UID} -g ${GID} ${USER}

RUN apt-get install -y \
			git \
			libpq-dev \
			libsqlite3-dev && \
	pip install --upgrade pip && \
	pip install virtualenv

COPY ./include/pcapi ${USER_HOME}/pcapienv

COPY ./include/survey_test.json ${USER_HOME}

COPY ./include/survey_test ${USER_HOME}/survey_test

COPY ./config_files/start.sh ${USER_HOME}

WORKDIR ${USER_HOME}

RUN	virtualenv pcapienv && \
	cd pcapienv && \
	. bin/activate && \
	pip install -e .

RUN mkdir .pcapi

RUN chown -R ${USER}:${GROUP} .

# survey-designer related

RUN apt-get -y install \
        	nodejs \
       		npm \
       		git

RUN ln -s /usr/bin/nodejs /usr/bin/node

COPY ./include/survey-designer ${USER_HOME}/survey-designer

RUN cd survey-designer  && \
	npm install && \
	./node_modules/jspm/jspm.js config registries.github.auth ${JSPM_GITHUB_AUTH} && \
	./node_modules/jspm/jspm.js install -y && \
	npm run bundle

# survey-preview related
COPY ./include/survey-preview ${USER_HOME}/survey-preview

RUN cd survey-preview && \
	npm install && \
	npm run bundle

# survey-viewer related
COPY ./include/fieldtrip-viewer ${USER_HOME}/fieldtrip-viewer

# app-linker related
COPY ./include/app-linker ${USER_HOME}/app-linker

RUN cd app-linker && \
	npm install

# healthcheck related
COPY ./include/healthcheck ${USER_HOME}/healthcheck

# Dependencies needed to run start.sh script
RUN apt-get install -y curl

# Mount point for data
RUN ln -s ${USER_HOME}/.pcapi /data && chown -R ${USER}:${GROUP} /data

# Defaults for executing a container 
ENTRYPOINT ["bash","start.sh"]