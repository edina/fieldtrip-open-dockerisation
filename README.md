# fieldtrip-open-dockerisation

This repository is intended to dockerise the fieldtrip-open ecosystem. This project requires a machine with docker installed
in order to build the image for fieldtrip-open and consequently run containers.

The dockerised version of fieldtrip-open has some dependencies, i.e. a workable docker image required cloning its different
submodules. If you have already cloned this repository, please type:

```bash
	$git pull origin master
	$git submodule foreach git pull origin master
```

Otherwise, you can clone this repository and all its dependencies at once by typping:

```bash
	$git clone --recursive https://github.com/edina/fieldtrip-open-dockerisation.git 
```

## Build

The process of building a docker image for fieldtrip-open requires:

```bash
	docker build -t fieldtrip-open .
```

Note that fieldtrip-open is the image name given but you can give to docker build another image name. We have ommitted the
version so for your docker machine will automatically rename the version to 'latest'.

## Run

Once the docker image has been built, you will be able to create a container that runs the fieldtrip-open ecosystem. Please,
type:

```bash
	docker run -p 8080:80 -d fieldtrip-open
```

The above command will execute a container on the port 8080 of your machine and it will be detached automatically. Remember,
fieldtrip-open is the name given when docker build is executed.

## Try it out!

There are different endpoints for fieldtrip-open ecosystem:

* PCAPI: [http://0.0.0.0:8080/1.3/pcapi](http://0.0.0.0:8080/1.3/pcapi)
* Survey designer: [http://0.0.0.0:8080/designer?sid=survey_test#/survey-designer](http://0.0.0.0:8080/designer?sid=survey_test#/survey-designer) (not working yet!)
* Survey preview: [http://0.0.0.0:8080/preview/#/?sid=survey_test](http://0.0.0.0:8080/preview/#/?sid=survey_test)
* Records viewer: [http://0.0.0.0:8080/viewer/?sid=survey_test](http://0.0.0.0:8080/viewer/?sid=survey_test)

Remember to change the host/port if your docker container is not running on localhost port 8080.



