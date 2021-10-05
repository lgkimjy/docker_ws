#!/bin/bash

docker run -it -d \
    --name ros2_lab_vnc \
    -p 8080:8080 \
    -v $HOME/Desktop/docker_share:/home/junyoung/docker_share \
    lgkimjy/ubuntu:mac-foxy-vnc