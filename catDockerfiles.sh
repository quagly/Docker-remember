#!/bin/bash

# concatenate all Dockerfiles to single dockerfile
# hack to see if this approach will work
cp root/Dockerfile .

cat home/Dockerfile python/Dockerfile groovy/Dockerfile | sed s/^FROM.*// | sed s/^MAINTAINER.*// >> Dockerfile



