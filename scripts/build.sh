#!/bin/bash

set -u -x

SERVICES=$(cat scripts/services.txt)

docker build -t openstack/seed:master images/seed

for service in $SERVICES
do
    docker-compose -f images/$service/dev.yml build
done