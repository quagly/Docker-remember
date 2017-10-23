#!/bin/bash
set -e

# for sql where command order matter it is best to using shell script
# there does not seem to be a docker mechanism to run sql in sort order
# however, we could easily modify the /docker-entrypoint.sh script to do this
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE ROLE poc WITH LOGIN PASSWORD 'poc';
    CREATE DATABASE poc;
    GRANT ALL PRIVILEGES ON DATABASE poc TO poc;
EOSQL
