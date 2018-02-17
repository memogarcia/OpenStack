#!/bin/bash

set -u

echo "Applying configuration"
mkdir /var/log/nova
cp /opt/neutron/etc/api-paste.ini /etc/neutron/api-paste.ini
cp /opt/neutron/etc/policy.json /etc/neutron/policy.json
cp /opt/neutron/etc/neutron/plugins/ml2/ml2_conf.ini.sample /etc/neutron/plugins/ml2/ml2_conf.ini

python2 /opt/configparse.py --config /opt/config/config-metadata.json --service "/etc/neutron/metadata_agent.ini"
python2 /opt/configparse.py --config /opt/config/config-dhcp-agent.json --service "/etc/neutron/dhcp_agent.ini"
python2 /opt/configparse.py --config /opt/config/config-linuxbridge-agent.json --service "/etc/neutron/plugins/ml2/linuxbridge_agent.ini"
python2 /opt/configparse.py --config /opt/config/config-ml2.json --service "/etc/neutron/plugins/ml2/ml2_conf.ini"
python2 /opt/configparse.py --config /opt/config/config.json --service "/etc/neutron/neutron.conf"

echo "DB configuration"
mysql  -hopenstack_mariadb -uroot -psecret \
    -e "CREATE DATABASE neutron;"

mysql  -hopenstack_mariadb -uroot -psecret \
       -e "GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'localhost' \
        IDENTIFIED BY 'secret';"

mysql  -hopenstack_mariadb -uroot -psecret \
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
    openstack endpoint create --region RegionOne network public http://openstack_neutron:9696

    echo "Creating internal endpoint"
    openstack endpoint create --region RegionOne network internal http://openstack_neutron:9696

    echo "Creating admin endpoint"
    openstack endpoint create --region RegionOne network admin http://openstack_neutron:9696
else
    echo "Skipping"
fi

echo "Creating symbolic link"
ln -s /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini

echo "Create databases tables"
neutron-db-manage --config-file /etc/neutron/neutron.conf \
                        --config-file /etc/neutron/plugins/ml2/ml2_conf.ini \
                        upgrade head

echo "Starting supervisord"
supervisord