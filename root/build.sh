#!/bin/sh

docker build --squash --tag root . 2>&1 | tee ../log/rootbuild.log
