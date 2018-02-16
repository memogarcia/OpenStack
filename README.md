# Openstack deployment on containers

Deploying OpenStack using containers allows an easy customization and flexibility on how to deploy
the platform for development, testing and _production_ environments.

Current deployment: **stable/queens**

## Infra services

* [Docker](services/infra/docker/README.md)

## Third-party services

Let's configure the third-party services need it for OpenStack to run.

* [Seed](services/third-party/seed/README.md)
* [MariaDB/MySQL](services/third-party/mariadb/README.md)
* [PostgreSQL](services/third-party/postgresql/README.md) **Optional Database**
* [Memcached](services/third-party/memcached/README.md)
* [Rabbitmq](services/third-party/rabbitmq/README.md)
* [Onos](services/third-party/onos/README.md) **Optional SDN**

## OpenStack services

* [Keystone](services/openstack/keystone/README.md)
* [Glance](services/openstack/glance/README.md)
* [Neutron](services/openstack/neutron/README.md)
* [Nova](services/openstack/nova/README.md)
* [Cinder](services/openstack/cinder/README.md)
* [Horizon](services/openstack/horizon/README.md)

## Start OpenStack

    ./scripts/build.sh
    ./scripts/docker-network-create.sh
    ./scripts/docker-volume-create.sh
    ./scripts/start.sh

## Verify installation

    source osrc-v3
    openstack project list
    openstack image list
    openstack server list
    openstack network list

## References

[OpenStack installation Guide](https://docs.openstack.org/install-guide/)