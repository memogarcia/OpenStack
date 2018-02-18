#!/bin/bash

set -u -x

VOLUMES=$(cat scripts/volumes.txt)

for volume in $VOLUMES
do
    docker volume create "openstack_volume_$volume"
done
