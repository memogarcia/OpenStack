#!/bin/bash

set -u

echo "Running opendaylight server"
./bin/start

echo "Running opendaylight client"
./bin/client feature:install odl-netvirt-openstack odl-mdsal-apidocs odl-dlux-core
