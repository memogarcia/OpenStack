#!/bin/bash

set -u -x

for network in openstack-management-net openstack-public-net openstack-private-net openstack-swift-net
do
    docker network create "$network"
done