#!/bin/bash

ID=`docker ps | grep Up | grep 'services/blather' | cut -d ' ' -f 1`

[ "${ID}" == "" ] && echo "services/blather is not running" && exit 1

docker exec -it ${ID} bash
