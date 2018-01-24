##!/bin/bash
set -x

# DB configuration
psql -h 0.0.0.0 -p 5432 -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER keystone;
    ALTER USER keystone WITH PASSWORD 'secret';
    CREATE DATABASE keystone;
    GRANT ALL PRIVILEGES ON DATABASE keystone TO keystone;
EOSQL

# Sync keystone
keystone-manage db_sync

