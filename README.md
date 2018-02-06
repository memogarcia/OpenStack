# Openstack deployer

## Start docker services

## Docker networks

    ./create-docker-networks.sh

### Postgresql

postgres is case sensitive

    docker-compose -f postgresql/dev.yml

### Keystone

    docker-compose -f keystone/dev.yml up

    docker run -p 0.0.0.0:5000:5000 -p 0.0.0.0:35357:35357 --link optimistic_montalcini:optimistic_montalcini openstack/keystone:pike