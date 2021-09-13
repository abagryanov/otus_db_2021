#!/bin/bash
echo "host all all 0.0.0.0/0 md5" >>"$PGDATA/pg_hba.conf"

set -e
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    create table test (id int);
    create publication test_publication for table test;
    insert into test values (1), (2), (3);
EOSQL

cat >> ${PGDATA}/postgresql.conf <<EOF
wal_level = logical
archive_mode = on
archive_command = 'cd .'
max_wal_senders = 8
wal_keep_size = 128
EOF
