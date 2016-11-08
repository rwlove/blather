#!/bin/bash

# $1 = location
# $2 = command
LOCATION=${1}
COMMAND=${2}

case ${COMMAND} in
    on|off)
	TOPIC="voice/${LOCATION}/lights_${COMMAND}"
	;;
    relax|concentrate|reading|energize|romantic|movie|stretch)
	TOPIC="voice/${LOCATION}/lights_scene"
	;;
    bright|brighter|dim|dimmer)
	TOPIC="voice/${LOCATION}/lights_adjust"
	;;
    *)
	TOPIC="voice/${LOCATION}/lights_color"
	;;
esac

echo "The topic is: ${TOPIC}, the message is: ${COMMAND}"

mqtt-cli mosca "${TOPIC}" "${COMMAND}"

