#!/bin/bash

set -u

echo "> Creating sql user and database"
mysql -hopenstack_mariadb -umysql -psecret \
    -e "CREATE DATABASE nova_api;"
mysql -hopenstack_mariadb -umysql -psecret \
    -e "CREATE DATABASE nova;"
mysql -hopenstack_mariadb -umysql -psecret \
    -e "CREATE DATABASE nova_cell0;"

mysql -hopenstack_mariadb -umysql -psecret \
        -e "GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'localhost' \
        IDENTIFIED BY '$NOVA_DB_PASS';"
mysql -hopenstack_mariadb -umysql -psecret \
        -e "GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'%' \
        IDENTIFIED BY '$NOVA_DB_PASS';"

mysql -hopenstack_mariadb -umysql -psecret \
        -e "GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'localhost' \
        IDENTIFIED BY '$NOVA_DB_PASS';"
mysql -hopenstack_mariadb -umysql -psecret \
        -e "GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'%' \
        IDENTIFIED BY '$NOVA_DB_PASS';"

mysql -hopenstack_mariadb -umysql -psecret \
        -e "GRANT ALL PRIVILEGES ON nova_cell0.* TO 'nova'@'localhost' \
        IDENTIFIED BY '$NOVA_DB_PASS';"
mysql -hopenstack_mariadb -umysql -psecret \
        -e "GRANT ALL PRIVILEGES ON nova_cell0.* TO 'nova'@'%' \
        IDENTIFIED BY '$NOVA_DB_PASS';"

echo "Syncing api database"
nova-manage api_db sync

echo "Registering cell0 database"
nova-manage cell_v2 map_cell0

echo "Create cell1 cell"
nova-manage cell_v2 create_cell --name=cell1 --verbose

echo "Syncing nova database"
nova-manage db sync

echo "Verify cell0 and cell1 are registered"
nova-manage cell_v2 list_cells

source /opt/osrc-v3

echo "Creating user"
if [ -z `openstack user list -f csv -q |grep nova` ]
then
    openstack user create --domain Default --password secret nova
else
    echo "Skipping"
fi

echo "Adding to role admin"
openstack role add --project service --user nova admin

echo "Creating nova service"
if [ -z `openstack service list -f csv -q |grep nova` ]
then
    openstack service create --name nova --description "OpenStack Compute" compute
else
    echo "Skipping"
fi

endpoint=`openstack endpoint list -f csv -q |grep nova`
if [ -z "$endpoint" ]
then
    echo "Creating public endpoint"
    openstack endpoint create --region RegionOne compute public http://openstack_nova:8774/v2.1

    echo "Creating internal endpoint"
    openstack endpoint create --region RegionOne compute internal http://openstack_nova:8774/v2.1

    echo "Creating admin endpoint"
    openstack endpoint create --region RegionOne compute admin http://openstack_nova:8774/v2.1
else
    echo "Skipping"
fi

echo "Creating placement service"
if [ -z `openstack user list -f csv -q |grep placement` ]
then
    openstack user create --domain Default --password secret placement
else
    echo "Skipping"
fi

echo "Adding to role admin"
openstack role add --project service --user placement admin

echo "Creating nova placement service"
if [ -z `openstack service list -f csv -q |grep placement` ]
then
    openstack service create --name placement --description "Placement API" placement
else
    echo "Skipping"
fi

endpoint=`openstack endpoint list -f csv -q |grep placement`
if [ -z "$endpoint" ]
then
    echo "Creating public endpoint"
    openstack endpoint create --region RegionOne placement public http://openstack_nova:8778/v2.1

    echo "Creating internal endpoint"
    openstack endpoint create --region RegionOne placement internal http://openstack_nova:8778/v2.1

    echo "Creating admin endpoint"
    openstack endpoint create --region RegionOne placement admin http://openstack_nova:8778/v2.1
else
    echo "Skipping"
fi

echo "Running the api's"
nova-api &
nova-consoleauth &
nova-scheduler &
nova-conductor &
nova-novncproxy