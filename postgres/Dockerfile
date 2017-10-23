FROM postgres
LABEL maintainer="Michael West <Michael.West@cambiahealth.com>"

# lets have a vim editor
RUN apt-get update && apt-get install -y vim

COPY init-user-db.sh /docker-entrypoint-initdb.d/

