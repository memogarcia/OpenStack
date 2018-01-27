#!/bin/bash
set -x

export PGPASSWORD=secret

# DB configuration
psql -h openstack_postgresql -p 5432 -v ON_ERROR_STOP=1 --username "admin" <<-EOSQL
    CREATE USER keystone;
    ALTER USER keystone WITH PASSWORD 'secret';
    CREATE DATABASE keystone;
    GRANT ALL PRIVILEGES ON DATABASE keystone TO keystone;
EOSQL

# Sync keystone
keystone-manage db_sync

# Initialize fernet key repositories
keystone-manage fernet_setup --keystone-user http --keystone-group http
keystone-manage credential_setup --keystone-user http --keystone-group http

# Bootstrap the service

keystone-manage bootstrap --bootstrap-password secret \
  --bootstrap-username admin \
  --bootstrap-project-name admin \
  --bootstrap-role-name admin \
  --bootstrap-service-name keystone \
  --bootstrap-region-id RegionOne \
  --bootstrap-admin-url http://0.0.0.0:35357/v3/ \
  --bootstrap-internal-url http://0.0.0.0:35357/v3/ \
  --bootstrap-public-url http://0.0.0.0:5000/v3/ \
  --bootstrap-region-id RegionOne

# echo "# Starting keystone..."
/usr/bin/httpd -D "FOREGROUND" -f /etc/httpd/conf.d/wsgi-keystone.conf
