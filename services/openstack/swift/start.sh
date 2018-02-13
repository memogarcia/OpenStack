#!/bin/bash

set -u

echo "DB configuration"
mysql  -hopenstack_mariadb -uroot -psecret \
    -e "CREATE DATABASE swift;"

mysql  -hopenstack_mariadb -uroot -psecret \
       -e "GRANT ALL PRIVILEGES ON swift.* TO 'swift'@'localhost' \
        IDENTIFIED BY 'secret';"

mysql  -hopenstack_mariadb -uroot -psecret \
       -e "GRANT ALL PRIVILEGES ON swift.* TO 'swift'@'%' \
        IDENTIFIED BY 'secret'"

echo "Syncing db"
cinder-manage db sync

source /opt/osrc-v3

echo "Creating user"
if [ -z `openstack user list -f csv -q |grep swift` ]
then
    openstack user create --domain Default --password secret swift
else
    echo "Skipping"
fi


echo "Creating role"
openstack role add --project service --user swift admin

echo "Creating cinder service"
if [ -z `openstack service list -f csv -q |grep cinder` ]
then
    openstack service create --name swift --description "OpenStack Object Storage" object-store
else
    echo "Skipping"
fi

endpoint=`openstack endpoint list -f csv -q |grep swift`
if [ -z "$endpoint" ]
then
    echo "Creating public endpoint"
    openstack endpoint create --region RegionOne object-store public http://openstack_swift:8081/v1/AUTH_%\(project_id\)s

    echo "Creating internal endpoint"
    openstack endpoint create --region RegionOne object-store internal http://openstack_swift:8081/v1/AUTH_%\(project_id\)s

    echo "Creating admin endpoint"
    openstack endpoint create --region RegionOne object-store admin http://openstack_swift:8081/v1/AUTH_%\(project_id\)s
else
    echo "Skipping"
fi

echo "Starting supervisord"
supervisord