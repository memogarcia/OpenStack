#!/bin/bash

set -u -x

OPENSTACK_SERVICES=$(cat scripts/openstack_services.txt)
THIRD_PARTY_SERVICES=$(cat scripts/third_party_services.txt)
INFRA_SERVICES=$(cat scripts/infra_services.txt)

echo "Building the seed image"
docker build -t openstack/seed:latest services/third-party/seed

echo "Building infra services"
for service in $INFRA_SERVICES
do
    docker-compose -f services/infra/$service/dev.yml build
done

echo "Building third party services"
for service in $THIRD_PARTY_SERVICES
do
    docker-compose -f services/third-party/$service/dev.yml build
done

echo "Building OpenStack services"
for service in $OPENSTACK_SERVICES
do
    docker-compose -f services/openstack/$service/dev.yml build
done