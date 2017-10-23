#!/bin/bash
# start up the container and initialize the database
# so all local processes can connect
docker run --name postgrestest -e POSTGRES_PASSWORD=test -d mypostgres
