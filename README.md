# Openstack deployer

## Start OpenStack

    ./scripts/build.sh
    ./scripts/docker-network-create.sh
    ./scripts/start.sh

## Verify installation

    source osrc-v3
    openstack project list
    openstack image list
    openstack server list
