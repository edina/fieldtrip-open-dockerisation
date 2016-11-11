#!/bin/bash

/usr/sbin/apache2ctl -k start

if [ $? -eq 0 ]; then
	curl -v -H "Content-Type: application/json" -X PUT --data-binary "@survey_test.json" http://0.0.0.0/1.3/pcapi/editors/local/00000000-0000-0000-0000-000000000000/survey_test.json
else
	echo 'Error starting apache'
fi

/usr/sbin/apache2ctl -k stop

/usr/sbin/apache2ctl -D FOREGROUND
