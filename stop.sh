#!/bin/bash

docker stop `docker ps | grep services/blather | cut -d ' ' -f 1`
