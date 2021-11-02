#!/bin/bash

docker run -it -d \
    --name ros1_vnc \
    -p 2020:2020 \
    --privileged \
    -v $HOME/Desktop/docker_share:/home/junyoung/docker_share \
	lgkimjy/ubuntu:mac-melodic-vnc