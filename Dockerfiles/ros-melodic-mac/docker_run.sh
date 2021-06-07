#!/bin/bash

ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost +$ip

docker run -it -d \
    --name simulation \
    -e DISPLAY=$ip:0 \
    -v $HOME/Desktop/docker_share:/home/junyoung/catkin_ws/src \
    lgkimjy/ubuntu:arm64
