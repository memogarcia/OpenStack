#!/bin/bash

set -u -x

SERVICES="postgresql memcached rabbitmq keystone"

for service in $SERVICES
do
    docker-compose -f images/$service/dev.yml up -d
done