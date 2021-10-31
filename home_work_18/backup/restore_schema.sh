#!/bin/bash

set -e
mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<-EOSQL
  create database if not exists world;
  use world;
  source /tmp/backup/world_db.sql;
EOSQL

openssl des3 -salt -k "password" -d -in /tmp/backup/stream/backup_des.xbstream.gz.des3 -out /tmp/backup/stream/backup_des.xbstream.gz
gzip -d /tmp/backup/stream/backup_des.xbstream.gz
cd /tmp/backup/stream
xbstream -x < backup_des.xbstream
xtrabackup --prepare --apply-log-only --target-dir=/tmp/backup/stream
xtrabackup --copy-back --target-dir=/tmp/backup/stream --datadir=/tmp/backup/stream2