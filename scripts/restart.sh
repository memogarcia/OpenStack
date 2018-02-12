#!/bin/bash

set -u -x

OPENSTACK_SERVICES=$(cat scripts/openstack_services.txt)
THIRD_PARTY_SERVICES=$(cat scripts/third_party_services.txt)

echo "Restarting third party services"
for service in $THIRD_PARTY_SERVICES
do
    docker-compose -f services/third-party/$service/dev.yml restart
done

echo "Waiting for the third party services to restart"
sleep 10

echo "Restarting OpenStack services"
for service in $OPENSTACK_SERVICES
do
    docker-compose -f services/openstack/$service/dev.yml restart
done