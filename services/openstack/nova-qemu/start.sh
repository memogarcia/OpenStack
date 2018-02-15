#!/bin/bash

set -u

echo "Applying configuration"

cp /opt/nova/etc/nova/api-paste.ini etc/nova/api-paste.ini
cp /opt/nova/etc/nova/cells.json /etc/nova/cells.json
cp /opt/nova/etc/nova/logging_sample.conf /etc/nova/logging.conf
cp /opt/nova/etc/nova/nova-config-generator.conf /etc/nova/nova-config-generator.conf
cp /opt/nova/etc/nova/nova-policy-generator.conf /etc/nova/nova-policy-generator.conf
cp /opt/nova/etc/nova/rootwrap.conf /etc/nova/rootwrap.conf
cp /opt/nova/etc/nova/rootwrap.d/api-metadata.filters /etc/nova/rootwrap.d/api-metadata.filters
cp /opt/nova/etc/nova/rootwrap.d/compute.filters /etc/nova/rootwrap.d/compute.filters
cp /opt/nova/etc/nova/rootwrap.d/network.filters /etc/nova/rootwrap.d/network.filters

RUN python2 /opt/configparse.py --config /opt/config/config-nova.json --service "/etc/nova/nova.conf"
RUN python2 /opt/configparse.py --config /opt/config/config-nova-compute.json --service "/etc/nova/nova-compute.conf"

source /opt/osrc-v3

echo "Creating nova-compute service"
openstack compute service list --service nova-compute

nova-manage cell_v2 discover_hosts --verbose

echo "Starting supervisord"
supervisord