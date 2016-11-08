#!/bin/bash

BUILD_ROOT=${PWD}

. settings.conf

[ ! -d logs ] && mkdir logs/
[ ! -f logs/blather.log ] && touch logs/blather.log

docker run \
       --privileged \
       -dt \
       -v /etc/localtime:/etc/localtime:ro \
       -v /dev/snd:/dev/snd \
       -v ${BUILD_ROOT}/logs/blather.log:/blather.log \
       -v ${BUILD_ROOT}/config/commands.conf:/root/.config/blather/commands.conf \
       -v ${BUILD_ROOT}/config/sentences.corpus:/root/.config/blather/sentences.corpus \
       -h blather \
       --restart=always \
       services/blather /usr/local/bin/runBlather.sh
#       -v ${BUILD_ROOT}/config/lm:/root/.config/blather/language/lm \
#       -v ${BUILD_ROOT}/config/dic:/root/.config/blather/language/dic \
