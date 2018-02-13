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
    openstack network list

## Endpoints

### Openstack

| Endpoint        | Port     |
| ------------- | ------------- |
| Keystone Admin | 35357      |
| Keystone Public | 5000      |
| Glance API | 9292      |
| Cinder API | 8776      |
| Nova API | 8774      |
| Nova Placement | 8778      |
| Neutron API | 9696    |
| Horizon | 8000    |
| Swift API | 8181      |  ## conflicts with Onos and OpenDayLight

### Third-Party

| Endpoint        | Port     |
| ------------- | ------------- |
| MariaDB | 3306      |
| PostgreSQL | 5432      |
| Memcached | 11211      |
| Rabbitmq | 5672 15672      |
| OpenDayLight | 2400 6633 6653 6640 8101 **8181**      |
| Onos | 6653 6640 8101 **8181** 9876      |
| Portainer | 9500      |
| CAdvisor | 9600      |