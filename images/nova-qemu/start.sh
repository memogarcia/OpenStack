#!/bin/bash

# set -u

source /opt/osrc-v3

echo "Creating nova-compute service"
openstack compute service list --service nova-compute

nova-manage cell_v2 discover_hosts --verbose

echo "Starting nova-compute"
/usr/sbin/libvirtd &
/usr/sbin/virtlogd &
nova-api-metadata --log-file=/var/log/nova/nova-metadata.log &
nova-compute --config-file /etc/nova/nova.conf --config-file /etc/nova/nova-compute.conf --log-file=/var/log/nova/nova-compute.log
