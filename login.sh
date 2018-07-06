#!/bin/bash

# login shell
# mount ssh directory for keys
# mount aws directory for keys
# things that don't live in a directory are put in .docker-extras
# I'm naming the container now since I only ever use one

docker run \
  --name full-running \
  --mount type=bind,source=${HOME}/.ssh,target=/home/developer/.ssh,readonly \
  --mount type=bind,source=${HOME}/.aws,target=/home/developer/.aws,readonly \
  --mount type=bind,source=${HOME}/.docker-extras,target=/home/developer/.docker-extras,readonly \
  --rm -it \
  full \
  bash -il
