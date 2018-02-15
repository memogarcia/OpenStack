#!/bin/bash

set -u

echo "Applying configuration"
cp /opt/glance/etc/glance-api.conf /etc/glance/glance-api.conf
cp /opt/glance/etc/glance-api-paste.ini /etc/glance/glance-api-paste.ini
cp /opt/glance/etc/glance-registry-paste.ini /etc/glance/glance-registry-paste.ini
cp /opt/glance/etc/glance-registry.conf /etc/glance/glance-registry.conf
cp /opt/glance/etc/schema-image.json /etc/glance/schema-image.json
cp /opt/glance/etc/policy.json /etc/glance/policy.json

python2 /opt/configparse.py --config /opt/config/config-api.json --service "/etc/glance/glance-api.conf"
python2 /opt/configparse.py --config /opt/config/cconfig-registry.json --service "/etc/glance/glance-registry.conf"

echo "DB configuration"
mysql  -hopenstack_mariadb -uroot -psecret \
    -e "CREATE DATABASE glance;"

mysql  -hopenstack_mariadb -uroot -psecret \
       -e "GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' \
        IDENTIFIED BY 'secret';"

mysql  -hopenstack_mariadb -uroot -psecret \
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

echo "Starting supervisord"
supervisord
