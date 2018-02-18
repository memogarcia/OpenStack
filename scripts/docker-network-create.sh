#!/bin/bash

set -u -x

NETWORKS=$(cat scripts/networks.txt)

for network in $NETWORKS
do
    docker network create "$network"
done

# docker network create --subnet 172.18.0.0/16  --gateway 172.18.0.1 openstack-management-net