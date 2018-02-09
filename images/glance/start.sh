#!/bin/bash

set -u

echo "DB configuration"
mysql  -hopenstack_mariadb -umysql -psecret \
      -e "CREATE DATABASE glance;"

mysql  -hopenstack_mariadb P -umysql -psecret \
       -e "GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' \
          IDENTIFIED BY 'secret';"

mysql  -hopenstack_mariadb -umysql -psecret \
       -e "GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%' \
          IDENTIFIED BY 'secret'"

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
    openstack endpoint create --region RegionOne image public http://openstack_glance:9292

    echo "Creating internal endpoint"
    openstack endpoint create --region RegionOne image internal http://openstack_glance:9292

    echo "Creating admin endpoint"
    openstack endpoint create --region RegionOne image admin http://openstack_glance:9292
else
    echo "Skipping"
fi

echo "Starting glance api's"
glance-api &
glance-registry