#!/bin/bash
set -x -u

export PGPASSWORD=secret

echo "DB configuration"
psql -h openstack_postgresql -p 5432 -v ON_ERROR_STOP=1 --username "admin" <<-EOSQL
    CREATE USER keystone;
    ALTER USER keystone WITH PASSWORD 'secret';
    CREATE DATABASE keystone;
    GRANT ALL PRIVILEGES ON DATABASE keystone TO keystone;
EOSQL

echo "Sync keystone database"
keystone-manage db_sync

echo "Initialize fernet key repositories"
keystone-manage fernet_setup --keystone-user http --keystone-group http
keystone-manage credential_setup --keystone-user http --keystone-group http

"Bootstrap the service"
keystone-manage bootstrap \
  --bootstrap-password secret \
  --bootstrap-username admin \
  --bootstrap-project-name admin \
  --bootstrap-role-name admin \
  --bootstrap-service-name keystone \
  --bootstrap-region-id RegionOne \
  --bootstrap-admin-url http://openstack_keystone:35357/v3/ \
  --bootstrap-internal-url http://openstack_keystone:35357/v3/ \
  --bootstrap-public-url http://openstack_keystone:5000/v3/


keystone-manage bootstrap \
  --bootstrap-password secret \
  --bootstrap-project-name service

echo "Starting keystone..."
/usr/bin/httpd -D "FOREGROUND" -f /etc/httpd/conf.d/wsgi-keystone.conf
