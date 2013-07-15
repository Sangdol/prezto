#!/bin/bash

echo "gradle cleanEclipse eclipse"
./gradlew cleanEclipse eclipse &> /dev/null

if [ "$(./gradlew build | grep FAILED | wc -l)" -ge 1 ]
then
	/usr/bin/notify-send 'Gradle failed';
	echo "$(date) - Build failed"
else
	echo "$(date) - Build success"
fi
