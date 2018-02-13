#!/bin/bash

set -u -x

NETWORKS=$(cat scripts/networks.txt)

for network in $NETWORKS
do
    docker network rm "$network"
done