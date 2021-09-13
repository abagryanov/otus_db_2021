FROM postgres:13.4

RUN apt-get update && apt-get install -y iputils-ping

COPY ./setup-replica.sh /docker-entrypoint-initdb.d/setup-replica.sh

RUN chmod 0666 /docker-entrypoint-initdb.d/setup-replica.sh