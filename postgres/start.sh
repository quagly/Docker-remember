#!/bin/bash
# start up the container and initialize the database
# so all local processes can connect

#docker run --name postgrestest -e POSTGRES_PASSWORD=test -d mypostgres

# expose port 5432 to local port 5432
# note assuming default bridge network
# bind to localhost only, don't want to connect from anywhere
docker run -p 127.0.0.1:5432:5432 --name postgrestest -d mypostgres
