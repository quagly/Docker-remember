# Docker-remember

Getting started with docker
this is a container to use for development that includes python and groovy

current setup is for containers to be built on eachother

centos:centos7->root->home->python->groovy

Basic use is to create Dockerfile, build, run test.

	$./catDockerfiles.sh
  $./build.sh
  $./run.sh

TODO:

change names to label naming standard like root:latest or root:7.1.3 rather than just root
investigate naming conventions for docker
