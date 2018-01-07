#!/bin/bash

# login shell
# mount ssh directory for keys
# I'm naming the container now since I only every use one

# example volume syntax
# mounts are read only since I don't want to mess up the host from the container
#docker run \
#  --volume ~/.ssh:/home/developer/.ssh:ro \
#  --volume ~/.aws:/home/developer/.aws:ro \
#  --name full-running \
#  --rm -it \
#  full \
#  bash -il

# example mount syntax which is the newer more flexible way
# though it doesn't really matter since we are only using bind mounts
docker run \
  --name full-running \
  --mount type=bind,source=${HOME}/.ssh,target=/home/developer/.ssh,readonly \
  --mount type=bind,source=${HOME}/.aws,target=/home/developer/.aws,readonly \
  --rm -it \
  full \
  bash -il




