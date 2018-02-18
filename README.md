# Openstack deployment on containers

Deploying OpenStack using containers allows an easy customization and flexibility on how to deploy
the platform for development, testing and _production_ environments.

Current deployment: **stable/queens**

## Infra services

* [Docker](services/infra/docker/README.md)
* [Seed](services/third-party/seed/README.md)

## Host configuration

The default configuration for this environment is composed by 3 main components that need to run on the host:

* [Docker](services/infra/docker/README.md)
* [Libvirtd](services/infra/libvirtd/README.md)
* [OpenVSwitch](services/infra/openvswitch/README.md)

Docker will act as the control plane for OpenStack while the host will provide the hypervisor, network and storage directly on the host.

![host_diagram](services/infra/docker/host.png)

## Network topology

This is the default network topology, 2 networks are used:

* openstack-management-net: All openstack traffic goes through here
* openstack-provider-net: Instances get IPs in this network

![simplified_network_diagram](services/infra/docker/simplified_networks.png)

## Third-party services

Configure the third-party services needed for OpenStack to run.

* [MariaDB/MySQL](services/third-party/mariadb/README.md)
* [PostgreSQL](services/third-party/postgresql/README.md) **Optional Database**
* [Memcached](services/third-party/memcached/README.md)
* [Rabbitmq](services/third-party/rabbitmq/README.md)
* [Onos](services/third-party/onos/README.md) **Optional SDN**
* [Minio](services/third-party/minio/README.md) **Optional Object Storage**

## OpenStack services

* [Keystone](services/openstack/keystone/README.md)
* [Glance](services/openstack/glance/README.md)
* [Neutron](services/openstack/neutron/README.md)
* [Nova](services/openstack/nova/README.md)
* [Nova-Qemu](services/openstack/nova-qemu/README.md)
* [Cinder](services/openstack/cinder/README.md)
* [Horizon](services/openstack/horizon/README.md)

## Extending OpenStack services

* [Custom API](services/custom/api/README.md)
* [Custom Backend](services/custom/backend/README.md)

## Start OpenStack

Modify [scripts/infra_services.txt](scripts/infra_services.txt), [scripts/third_party_services.txt](scripts/third_party_services.txt) and [scripts/openstack_services.txt](scripts/openstack_services.txt) to run the services you need.

    ./scripts/build.sh
    ./scripts/docker-network-create.sh
    ./scripts/docker-volume-create.sh
    ./scripts/start.sh

## Verify installation

    source osrc-v3
    openstack project list
    openstack image list
    openstack network list
    openstack server list

## References

[OpenStack installation Guide](https://docs.openstack.org/install-guide/)