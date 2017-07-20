#!/bin/bash

# concatenate all Dockerfiles to single dockerfile
# hack to see if this approach will work
cp root/Dockerfile .

# remove headers from child Dockerfiles
cat home/Dockerfile python/Dockerfile groovy/Dockerfile clojure/Dockerfile | sed s/^FROM.*// | sed s/^LABEL.*// >> Dockerfile

# add testing at the end
# note that I am hardcoding /home/developer
# because $HOME will resolve to this scripts context
# not the containers
cat <<HERE >> Dockerfile

# get test script and run it    
COPY test.sh /home/developer
CMD /home/developer/test.sh 
HERE

