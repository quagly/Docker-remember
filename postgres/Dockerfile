FROM postgres
LABEL maintainer="Michael West <quagly@gmail.com>"

# lets have a vim editor
RUN  echo '20171023' > /dev/null;\
      apt-get update && apt-get install -y vim

COPY init-user-db.sh /docker-entrypoint-initdb.d/

