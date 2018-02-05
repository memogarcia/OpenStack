#!/bin/bash

set -u -x

for network in openstack-management-net openstack-public-net openstack-private-net
do
    docker network rm "$network"
done