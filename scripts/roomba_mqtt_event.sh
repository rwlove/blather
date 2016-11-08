#!/bin/bash

# $1 = command
COMMAND=${1}

TOPIC="voice/roomba/${COMMAND}"

echo "The topic is: ${TOPIC}, the message is: ${COMMAND}"

mqtt-cli mosca "${TOPIC}" "${COMMAND}"

