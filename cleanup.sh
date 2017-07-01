#!/bin/sh
# clean up after using docker

# stop and remove all containers 
if [[ $(docker ps -a -q) ]]; then
	docker stop $(docker ps -a -q) 
  docker rm   $(docker ps -a -q)
fi
# remove all dangling images                                                                                                                                                
if [[ $(docker image ls -q --filter "dangling=true") ]]; then
	docker rmi $(docker  image ls -q --filter "dangling=true")     
fi
