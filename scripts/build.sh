#!/bin/bash

set -u -x

SERVICES="keystone glance"

docker build -t openstack/seed images/seed/

for service in $SERVICES
do
    docker-compose -f images/$service/dev.yml build
done