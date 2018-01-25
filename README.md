# Openstack deployer

## Start docker services

### Postgresql

    docker run --name openstack-postgresql -p 0.0.0.0:5432:5432 openstack/postgres

### Keystone

    docker run -p 0.0.0.0:5000:5000 -p 0.0.0.0:35357:35357 --link optimistic_montalcini:optimistic_montalcini openstack/keystone:pike