#!/bin/bash
echo "host all all 0.0.0.0/0 md5" >>"$PGDATA/pg_hba.conf"

until ping -c 1 -W 1 ${PG_MASTER_HOST:?missing environment variable. PG_MASTER_HOST must be set}
    do
        echo "Waiting for master to ping..."
        sleep 1s
done
until psql -h ${PG_MASTER_HOST} -p ${PG_MASTER_PORT} -U ${PG_MASTER_USER} ${PG_MASTER_DB}
    do
        echo "Waiting for master to connect..."
        sleep 1s
done

set -e
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    create table test (id int);
    create subscription test_subscription
    connection 'host=$PG_MASTER_HOST port=$PG_MASTER_PORT user=$PG_MASTER_USER password=$PG_MASTER_PASSWORD dbname=$PG_MASTER_DB'
    publication test_publication with (copy_data = false);
EOSQL