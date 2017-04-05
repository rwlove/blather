#!/bin/bash

echo "Determining Audio Device" >> /blather.log
echo "- searching for 'CODEC [USB audio CODEC]'" >> /blather.log
arecord -l
DEV=`arecord -l | grep "CODEC \[USB audio CODEC\]" | cut -d ":" -f -1 | cut -d " " -f 2`
echo "Audio Device Number is: ${DEV}" >> /blather.log

echo "Updating Language Files" >> /blather.log

/blather/language_updater.sh 2>&1 | tee /blather.log

echo "Starting Blather" >> /blather.log

python Blather.py -c -m ${DEV} 2>&1 | tee /blather.log

echo "Blather Exited with return code: '$?'" >> /blather.log
