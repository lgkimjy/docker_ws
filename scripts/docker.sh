#!/bin/bash

ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost +$ip

docker run -it \
	-e DISPLAY=$ip:0 \
    -p 11311:11311 \
    lgkimjy/ubuntu:arm64
