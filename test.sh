#!/bin/bash -l
# note this needs to be a login shell so that
# sdkman will set $JAVA_HOME for groovy
set -e

# test python versions
cd $HOME/python/cfn-manage
tox
# test groovy enviornment
cd $HOME/groovy/neo4j
./gradlew
./gradlew clean
