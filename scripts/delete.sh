#!/bin/bash

set -u -x

SERVICES=$(cat scripts/services.txt)

for service in $SERVICES
do
    docker-compose -f images/$service/dev.yml down -v
done
