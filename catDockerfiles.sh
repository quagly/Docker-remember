#!/bin/bash

# concatenate all Dockerfiles to single dockerfile
# hack to see if this approach will work
cp root/Dockerfile .

# remove headers from child Dockerfiles
# not using clojure anymore, maybe remove since it is not including in testing
# so subject to entropy
cat home/Dockerfile python/Dockerfile groovy/Dockerfile | sed s/^FROM.*// | sed s/^LABEL.*// >> Dockerfile

# add testing at the end
# note that I am hardcoding /home/developer
# because $HOME will resolve to this scripts context
# not the containers

# also adding .gitconfig here
# because I use ssh keys for git auth
# in containers but those are mounted at run time
# so keys are not available during build
cat <<HERE >> Dockerfile

WORKDIR /home/developer
# get test script and run it
COPY test.sh /home/developer
COPY .gitconfig /home/developer
CMD /home/developer/test.sh
HERE

