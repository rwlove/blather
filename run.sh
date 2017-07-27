#!/bin/bash

BUILD_ROOT=${PWD}

[ ! -d logs ] && mkdir logs/
[ ! -f logs/blather.log ] && touch logs/blather.log

MODE=d #default is daemon
CMD=/usr/local/bin/runBlather.sh

while getopts ":i" opt; do
    case $opt in
	i)
	    MODE=i
	    CMD=/bin/bash
	    ;;
	\?)
	    echo "Invalid option: -$OPTARG" >&2
	    ;;
    esac
done

docker run \
       --privileged \
       -t${MODE} \
       --network="host" \
       -v /etc/localtime:/etc/localtime:ro \
       -v /dev/snd:/dev/snd \
       -v ${BUILD_ROOT}/logs/blather.log:/blather.log \
       -v ${BUILD_ROOT}/config/commands.conf:/root/.config/blather/commands.conf \
       -v ${BUILD_ROOT}/config/sentences.corpus:/root/.config/blather/sentences.corpus \
       -h blather \
       --restart=always \
       services/blather ${CMD}
