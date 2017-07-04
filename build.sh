#!/bin/sh

docker build --no-cache --squash --tag full . 2>&1 | tee log/fullbuild.log
