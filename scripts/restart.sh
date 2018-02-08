#!/bin/bash

set -u -x

SERVICES="postgresql memcached rabbitmq keystone glance"

for service in $SERVICES
do
    docker-compose -f images/$service/dev.yml restart
done