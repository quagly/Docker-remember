#!/bin/bash

# sync time between docker host and containers
# required for boto3 to authenticate

# see https://blog.shameerc.com/2017/03/quick-tip-fixing-time-drift-issue-on-docker-for-mac
# the agent install failed from that site.  Need to investigate

docker run --rm --privileged alpine hwclock -s
