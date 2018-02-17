#!/bin/bash

set -u -x

INFRA_SERVICES=$(cat scripts/infra_services.txt)

echo "Starting infra services"
for service in $INFRA_SERVICES
do
    docker-compose -f services/infra/$service/dev.yml up -d
done