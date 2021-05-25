#!/bin/bash

xhost +local:docker
xhost +192.168.10.115  # display x11 forwarding

docker run -it -d \
    --name simulation \
    -e DISPLAY=192.168.10.115:0 \
    -v $HOME/Desktop/docker_share:/home/junyoung/catkin_ws/src \
    lgkimjy/ubuntu:mac