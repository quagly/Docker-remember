#!/bin/sh
# clean up after using docker

echo "stop and remove all containers"
if [[ $(docker ps -a -q) ]]; then
	docker stop $(docker ps -a -q)
  docker rm   $(docker ps -a -q)
fi

echo "remove all dangling images"
if [[ $(docker image ls -q --filter "dangling=true") ]]; then
	docker rmi $(docker  image ls -q --filter "dangling=true")
fi

# I'm not yet creating volumes outside of `docker run`
# so this is fine.
echo "remove unused volumes"
docker volume prune --force
