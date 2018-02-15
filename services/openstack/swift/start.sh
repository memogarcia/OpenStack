#!/bin/bash

set -u

echo "Applying configuration"
cp /opt/swift/etc/account-server.conf-sample /etc/swift/account-server.conf
cp /opt/swift/etc/container-reconciler.conf-sample /etc/swift/container-reconciler.conf
cp /opt/swift/etc/container-server.conf-sample /etc/swift/container-server.conf
cp /opt/swift/etc/container-sync-realms.conf-sample /etc/swift/container-sync-realms.conf
cp /opt/swift/etc/dispersion.conf-sample /etc/swift/dispersion.conf
cp /opt/swift/etc/internal-client.conf-sample /etc/swift/internal-client.conf
cp /opt/swift/etc/keymaster.conf-sample /etc/swift/keymaster.conf
cp /opt/swift/etc/memcache.conf-sample /etc/swift/memcache.conf
cp /opt/swift/etc/mime.types-sample /etc/swift/mime.types
cp /opt/swift/etc/object-expirer.conf-sample /etc/swift/object-expirer.conf
cp /opt/swift/etc/object-server.conf-sample /etc/swift/object-server.conf
cp /opt/swift/etc/rsyncd.conf-sample /etc/swift/rsyncd.conf
cp /opt/swift/etc/swift-rsyslog.conf-sample /etc/swift/swift-rsyslog.conf
cp /opt/swift/etc/swift.conf-sample /etc/swift/swift.conf

RUN python2 /opt/configparse.py --config /opt/config/config-proxy.json --service "/etc/swift/proxy-server.conf"
RUN python2 /opt/configparse.py --config /opt/config/config.json --service "/etc/swift/swift.conf"

echo "DB configuration"
mysql  -hopenstack_mariadb -uroot -psecret \
    -e "CREATE DATABASE swift;"

mysql  -hopenstack_mariadb -uroot -psecret \
       -e "GRANT ALL PRIVILEGES ON swift.* TO 'swift'@'localhost' \
        IDENTIFIED BY 'secret';"

mysql  -hopenstack_mariadb -uroot -psecret \
       -e "GRANT ALL PRIVILEGES ON swift.* TO 'swift'@'%' \
        IDENTIFIED BY 'secret'"

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