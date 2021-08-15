#!/bin/bash

ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost +$ip

docker run -it -d \
    --name ros2 \
    -e DISPLAY=$ip:0 \
    -v $HOME/Desktop/docker_share:/home/junyoung/docker_share \
    lgkimjy/ubuntu:mac-foxy
