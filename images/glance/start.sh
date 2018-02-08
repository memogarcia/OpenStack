#!/bin/bash

set -u

export PGPASSWORD=secret

echo "DB configuration"
psql -h openstack_postgresql -p 5432 -v ON_ERROR_STOP=1 --username "admin" <<-EOSQL
    CREATE USER glance;
    ALTER USER glance WITH PASSWORD 'secret';
    CREATE DATABASE glance;
    GRANT ALL PRIVILEGES ON DATABASE glance TO glance;
EOSQL

echo "Syncing db"
glance-manage db_sync

source /opt/osrc-v3

echo "Creating user"
if [ -z `openstack user list -f csv -q |grep glance` ]
then
    openstack user create --domain Default --password secret glance
else
    echo "Skipping"
fi


echo "Creating role"
openstack role add --project service --user glance admin

echo "Creating glance service"
if [ -z `openstack service list -f csv -q |grep glance` ]
then
    openstack service create --name glance --description "OpenStack Image" image
else
    echo "Skipping"
fi

endpoint=`openstack endpoint list -f csv -q |grep glance`
if [ -z "$endpoint" ]
then
    echo "Creating public endpoint"
    openstack endpoint create --region RegionOne image public http://0.0.0.0:9292

    echo "Creating internal endpoint"
    openstack endpoint create --region RegionOne image internal http://0.0.0.0:9292

    echo "Creating admin endpoint"
    openstack endpoint create --region RegionOne image admin http://0.0.0.0:9292
else
    echo "Skipping"
fi

echo "Starting glance api's"
glance-api &
glance-registry