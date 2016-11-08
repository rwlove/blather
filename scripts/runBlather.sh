#!/bin/bash

echo "Updating Language Files" >> /blather.log

/blather/language_updater.sh 2>&1 | tee /blather.log

echo "Starting Blather" >> /blather.log

python Blather.py -c -m 1 2>&1 | tee /blather.log

echo "Blather Exited with return code: '$?'" >> /blather.log
