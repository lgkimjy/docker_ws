#!/bin/bash

#xhost +local:docker

docker run -it \
    -p 11311:11311 \
	#-v ~/docker_share/VOLUME1/:/home/ \
    lgkimjy/ubuntu:arm64
