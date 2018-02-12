#!/bin/sh

# squash fails, not sure why
docker build --squash --tag thinkstats . 2>&1 | tee ../log/thinkstats-build.log

# remember to build with no-cache to catch continuum updates
# docker build --no-cache --tag thinkstats . 2>&1 | tee ../log/thinkstats-build.log

