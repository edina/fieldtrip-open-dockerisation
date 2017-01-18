# fieldtrip-open-dockerisation

This repository is intended to dockerise the fieldtrip-open ecosystem. This project requires a machine with docker installed
in order to build the image for fieldtrip-open and consequently run containers.

The dockerised version of fieldtrip-open has some dependencies, please run the following commands after cloning:
```bash
	$git submodule init
	$git submodule update
```
or make sure that you clone this repository and all its dependencies at once by typping:
```bash
	$git clone --recursive https://github.com/edina/fieldtrip-open-dockerisation.git 
```

As this repository or its dependencies may be exposed to updates, may sure that you execute:

```bash
	$git pull origin master
	$git submodule foreach git pull origin master
```

for any new commit.

## Build

To build a docker image, please type:
```bash
	docker build -t fieldtrip-open .
```

If the above command fails, please type:
```bash
	docker build --build-arg JSPM_GITHUB_AUTH=<your_personal_access_token> -t fieldtrip-open .
```
which passes your personal access token from your github account in order to install some dependencies for survey-designer at its package manager, i.e. [jspm](http://jspm.io/).

## Run

Once the docker image has been built, you will be able to create a container that runs the fieldtrip-open ecosystem. Please,
type:

```bash
	docker run -p 8080:80 -d fieldtrip-open
```

The above command will execute a container on the port 8080 of your machine and it will be detached automatically. Remember,
fieldtrip-open is the image name given when docker build is executed.

If you want your data to be persisted, please run:

```bash
	docker run -p 8080:80 -d -v <host_src>:/data fieldtrip-open
```

## Try it out!

Go to [http://0.0.0.0:8080/](http://0.0.0.0:8080/). Remember to change the host/port if you executed docker run on a different host/port.



