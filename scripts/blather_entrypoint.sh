#!/bin/bash

# Close STDOUT file descriptor
exec 1<&-
# Close STDERR FD
exec 2<&-

# Open STDOUT as $LOG_FILE file for read and write.
exec 1<>/blather.log

# Redirect STDERR to STDOUT
exec 2>&1

echo "Determining Audio Device"
echo "- searching for 'CODEC [USB audio CODEC]'"
arecord -l
DEV=`arecord -l | grep "CODEC \[USB audio CODEC\]" | cut -d ":" -f -1 | cut -d " " -f 2`
echo "Audio Device Number is: ${DEV}"

echo "Updating Language Files"

/blather/language_updater.sh

echo "Starting Blather"

python Blather.py -c -m ${DEV}

echo "Blather Exited with return code: '$?'"
