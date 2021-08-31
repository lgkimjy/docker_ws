# Env settings
```
ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')          Retreive and save ip to ip variable
xhost +[name]          Server access control, given name is added to the list allowed to connect to the X server
```

# Docker run command
## General form
```
$ docker run [OPTIONS] IMAGE[:TAG|@DIGEST] [COMMAND] [ARG...]
```
## OPTIONS
```
-i, --interactive                 Keep STDIN open even if not attached
-t, --tty                         Allocate a pseudo-TTY
    --name string                 Assign a name to the container
    --network network             Connect a container to a network
    --gpus gpu-request            GPU devices to add to the container ('all' to pass all GPUs)
    --privileged                  Give extended privileges to this container
-e, --env list                    Set environment variables   [ ex) -e  DISPLAY=$ip:0 ]
-v, --volume list                 Bind mount a volume         [ ex) -v $HOME/shared_ws:/home/user/shared_ws ]
```
## COMMAND
```
/bin/bash
```
