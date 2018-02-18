#!/bin/bash

set -u -x

VOLUMES=$(cat scripts/volumes.txt)

for volume in $VOLUMES
do
    docker volume delete "openstack_volume_$volume"
done
