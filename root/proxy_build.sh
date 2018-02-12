#!/bin/sh

docker build --file Dockerfile.proxy --squash --tag root .
