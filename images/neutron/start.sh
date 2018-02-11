#!/bin/bash

set -u

echo "DB configuration"
mysql  -hopenstack_mariadb -umysql -psecret \
    -e "CREATE DATABASE neutron;"

mysql  -hopenstack_mariadb -umysql -psecret \
       -e "GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'localhost' \
        IDENTIFIED BY 'secret';"

mysql  -hopenstack_mariadb -umysql -psecret \
       -e "GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'%' \
        IDENTIFIED BY 'secret'"

source /opt/osrc-v3

echo "Creating user"
if [ -z `openstack user list -f csv -q |grep neutron` ]
then
    openstack user create --domain Default --password secret neutron
else
    echo "Skipping"
fi

echo "Creating role"
openstack role add --project service --user neutron admin

echo "Creating neutron service"
if [ -z `openstack service list -f csv -q |grep neutron` ]
then
    openstack service create --name neutron --description "OpenStack Networking" network
else
    echo "Skipping"
fi

endpoint=`openstack endpoint list -f csv -q |grep neutron`
if [ -z "$endpoint" ]
then
    echo "Creating public endpoint"
    openstack endpoint create --region RegionOne image public http://openstack_neutron:9696

    echo "Creating internal endpoint"
    openstack endpoint create --region RegionOne image internal http://openstack_neutron:9696

    echo "Creating admin endpoint"
    openstack endpoint create --region RegionOne image admin http://openstack_neutron:9696
else
    echo "Skipping"
fi

echo "Creating symbolic link"
ln -s /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini

echo "Create databases tables"
neutron-db-manage --config-file /etc/neutron/neutron.conf \
                        --config-file /etc/neutron/plugins/ml2/ml2_conf.ini \
                        upgrade head