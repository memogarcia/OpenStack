# MariaDB/MySQL

MariaDB/MySQL is the default database for OpenStack

## Configuration

For the database configuration, modify [model.yml](../../../model.yml) to match your database.

And for `config/config.json`:

```bash
    ...
    "connection": "postgresql://keystone:secret@openstack_mariadb.openstack-management-net/keystone"
    ...
```

## Starting the DB

    docker-compose -f dev.yml up