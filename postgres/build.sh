#!/bin/sh

docker build --no-cache --tag mypostgres . 2>&1 | tee log/postgres.log
# squash fails.  probably because no commands yet in dockerfile
# docker build --no-cache --squash --tag postgres . 2>&1 | tee log/postgres.log
