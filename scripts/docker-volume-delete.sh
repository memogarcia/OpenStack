#!/bin/bash

set -u -x

OPENSTACK_SERVICES=$(cat scripts/openstack_services.txt)
THIRD_PARTY_SERVICES=$(cat scripts/third_party_services.txt)
INFRA_SERVICES=$(cat scripts/infra_services.txt)
ALL_SERVICES="$OPENSTACK_SERVICES $THIRD_PARTY_SERVICES $INFRA_SERVICES"

for service in $ALL_SERVICES
do
    docker volume rm "openstack_volume_$service"
done