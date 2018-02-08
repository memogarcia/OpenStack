#!/bin/bash

set -u -x

SERVICES="postgresql memcached rabbitmq keystone glance nova"

for service in $SERVICES
do
    docker-compose -f ../images/$service/dev.yml up -d
done
