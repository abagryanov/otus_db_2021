FROM mysql:8.0.27

RUN mkdir -p /tmp/backup && \
    mkdir -p /tmp/backup/stream && \
    mkdir -p /tmp/backup/stream2
COPY ./backup/world_db.sql /tmp/backup
COPY ./backup/backup_des.xbstream.gz.des3 /tmp/backup/stream
COPY ./backup/restore_schema.sh /docker-entrypoint-initdb.d/restore_schema.sh

RUN chmod 777 -R /tmp/backup

RUN apt-get update && \
    apt-get install lsb-release -y && \
    apt-get install curl -y && \
    apt install wget -y && \
    cd /tmp && \
    wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb && \
    dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb && \
    apt-get update && \
    apt-get install -y percona-xtrabackup-80 && \
    apt-get install -y qpress && \
    apt-get install openssl

RUN cd /tmp/backup && \
    sed -n -e '/CREATE TABLE.*`city`/,/Table structure for table/p' world_db.sql > city.sql

CMD ["mysqld"]



