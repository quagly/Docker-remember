#!/bin/bash

# login shell
# mount ssh directory for keys
docker run --volume ~/.ssh:/home/developer/.ssh --rm -it full bash -il
