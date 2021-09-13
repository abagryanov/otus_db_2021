#!/bin/bash
if [ ! -s "$PGDATA/PG_VERSION" ]; then
echo "*:*:*:$PG_REPLICATION_USER:$PG_REPLICATION_PASSWORD" > ~/.pgpass

chmod 0600 ~/.pgpass

until ping -c 1 -W 1 ${PG_MASTER_HOST:?missing environment variable. PG_MASTER_HOST must be set}
    do
        echo "Waiting for master to ping..."
        sleep 1s
done
until pg_basebackup -h ${PG_MASTER_HOST} -D ${PGDATA} -U ${PG_REPLICATION_USER} -vP -W -R
    do
        echo "Waiting for master to connect..."
        sleep 1s
done

echo "host replication all 0.0.0.0/0 md5" >> "$PGDATA/pg_hba.conf"

set -e

cat >> ${PGDATA}/postgresql.auto.conf <<EOF
primary_conninfo = 'host=$PG_MASTER_HOST port=${PG_MASTER_PORT:-5432} user=$PG_REPLICATION_USER password=$PG_REPLICATION_PASSWORD'
hot_standby = on
EOF
chown postgres. ${PGDATA} -R
chmod 700 ${PGDATA} -R
fi

exec "$@"