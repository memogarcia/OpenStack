#!/bin/bash
set -x

./scripts/docker-network-create.sh

docker-compose -f images/postgresql/dev.yml up -d
docker-compose -f images/memcached/dev.yml up -d
docker-compose -f images/rabbitmq/dev.yml up -d

# docker-compose -f images/keystone/dev.yml up -d
