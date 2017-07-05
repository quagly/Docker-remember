# Docker-remember

Getting started with docker
this is a container to use for development that includes python and groovy

current setup is for containers to be built on eachother

centos:centos7->root->home->python->groovy

or create a single Dockerfile run 
	
	$./catDockerfiles.sh

which creates a single Dockerfile from all the child dockerfiles and adds test.sh


TODO:

change names to label naming standard like root:latest or root:7.1.3 rather than just root
investigate naming conventions for docker
