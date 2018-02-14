#!/bin/bash

set -u -x

OPENSTACK_SERVICES=$(cat scripts/openstack_services.txt)
THIRD_PARTY_SERVICES=$(cat scripts/third_party_services.txt)
INFRA_SERVICES=$(cat scripts/infra_services.txt)
ALL_SERVICES="$OPENSTACK_SERVICES $THIRD_PARTY_SERVICES $INFRA_SERVICES"

for service in $ALL_SERVICES
do
    docker volume create "openstack_volume_$service"
done

# what happens if you rerun this command with the data in the volume?
for service in $OPENSTACK_SERVICES
do
    docker volume create "openstack_volume_$service_etc"
    docker volume create "openstack_volume_$service_lib"
    docker volume create "openstack_volume_$service_log"
done

# the problem with external volumes is that they are not portable, but I guess is the same for networks.