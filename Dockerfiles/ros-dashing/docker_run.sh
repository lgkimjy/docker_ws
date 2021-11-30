#!/bin/bash

ip=$(ifconfig wlo1 | grep inet | awk '$1=="inet" {print $2}')
xhost +$ip

# xhost +local:

# xhost +

# --pid=host \
docker run --rm -it --privileged -d \
    --name ros2 \
    --net=host \
    --volume=/dev:/dev \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /dev/shm:/dev/shm \
    -e DISPLAY=$DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    lgkimjy/ubuntu:ros2