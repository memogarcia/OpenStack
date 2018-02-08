#!/bin/bash

# set -u

# source /opt/osrc-v3

# echo "Creating nova-compute service"
# if [ -z `openstack service list -f csv -q |grep nova` ]
# then
#     openstack service create --name nova --description "OpenStack Compute" compute
# else
#     echo "Skipping"
# fi
# openstack compute service list --service nova-compute

# echo "Starting nova-compute"
# # nova-compute &