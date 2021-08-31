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
-e, --env list                    Set environment variables
-v, --volume list                 Bind mount a volume
```
## COMMAND
```
/bin/bash
```
