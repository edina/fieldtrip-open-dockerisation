# fieldtrip-open-dockerisation

Documentation work is ongoing

URLs: 
	PCAPI:
	http://localhost:8080/1.3/pcapi
	survey-designer:
	http://localhost:8080/sd
	survey-preview:
	http://localhost:8080/survey-preview
	viewer:
	http://localhost:8080/viewer/?sid=test.json

Build the image:
	docker build -t fieldtrip-open .

Run a container for that image:
	docker run -p 8080:80 -d fieldtrip-open



