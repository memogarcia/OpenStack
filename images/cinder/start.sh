#!/bin/bash

set -u

echo "DB configuration"
mysql  -hopenstack_mariadb -uroot -psecret \
    -e "CREATE DATABASE cinder;"

mysql  -hopenstack_mariadb -uroot -psecret \
       -e "GRANT ALL PRIVILEGES ON cinder.* TO 'cinder'@'localhost' \
        IDENTIFIED BY 'secret';"

mysql  -hopenstack_mariadb -uroot -psecret \
       -e "GRANT ALL PRIVILEGES ON cinder.* TO 'cinder'@'%' \
        IDENTIFIED BY 'secret'"

echo "Syncing db"
cinder-manage db_sync

source /opt/osrc-v3

echo "Creating user"
if [ -z `openstack user list -f csv -q |grep cinder` ]
then
    openstack user create --domain Default --password secret cinder
else
    echo "Skipping"
fi


echo "Creating role"
openstack role add --project service --user cinder admin

echo "Creating cinder service"
if [ -z `openstack service list -f csv -q |grep cinder` ]
then
    openstack service create --name volumev2 --description "OpenStack Block Storage" volumev2
    openstack service create --name volumev3 --description "OpenStack Block Storage" volumev3
else
    echo "Skipping"
fi

endpoint=`openstack endpoint list -f csv -q |grep cinder`
if [ -z "$endpoint" ]
then
    echo "Creating public endpoint"
    openstack endpoint create --region RegionOne volumev2 public http://openstack_cinder:8776/v2/%\(project_id\)s

    echo "Creating internal endpoint"
    openstack endpoint create --region RegionOne volumev2 internal http://openstack_cinder:8776/v2/%\(project_id\)s

    echo "Creating admin endpoint"
    openstack endpoint create --region RegionOne volumev2 admin http://openstack_cinder:8776/v2/%\(project_id\)s

    echo "Creating public endpoint"
    openstack endpoint create --region RegionOne volumev3 public http://openstack_cinder:8776/v3/%\(project_id\)s

    echo "Creating internal endpoint"
    openstack endpoint create --region RegionOne volumev3 internal http://openstack_cinder:8776/v3/%\(project_id\)s

    echo "Creating admin endpoint"
    openstack endpoint create --region RegionOne volumev3 admin http://openstack_cinder:8776/v3/%\(project_id\)s
else
    echo "Skipping"
fi