#!/bin/bash
set -x -u

export PGPASSWORD=secret

echo "DB configuration"
psql -h openstack_postgresql -p 5432 -v ON_ERROR_STOP=1 --username "admin" <<-EOSQL
    CREATE USER glance;
    ALTER USER glance WITH PASSWORD 'secret';
    CREATE DATABASE glance;
    GRANT ALL PRIVILEGES ON DATABASE glance TO glance;
EOSQL

echo "Sync glance database"
glance-manage db_sync

echo "Starting glance using supervisord..."
exec /usr/bin/supervisord -n -c supervisord.conf