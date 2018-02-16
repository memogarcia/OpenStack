# Keystone

## Configuration

Modify the following files to match your environment:

* [config/config.json](config/config.json) which will map to `/etc/keystone/keystone.conf`.
* [dev.yml](dev.yml) to match your host environment.

By using `<container_name>.<network_name>` in the configuration file, we can segregate the network connectivity in the containers

```json
    ...
    "memcache_servers": "openstack_memcached.openstack-management-net:11211"
    ...
```

For the database configuration, modify [start.sh](start.sh) to match your database.
In this example, MariaDB is configured. If you want to use PostgreSQL, replace the DB configuration
with the following:

```bash
echo "DB configuration"
export PGPASSWORD=secret
psql -h openstack_postgresql -p 5432 -v ON_ERROR_STOP=1 --username "admin" <<-EOSQL
    CREATE USER keystone;
    ALTER USER keystone WITH PASSWORD 'secret';
    CREATE DATABASE keystone;
    GRANT ALL PRIVILEGES ON DATABASE keystone TO keystone;
EOSQL
```

## References

[Keystone installation Guide](https://docs.openstack.org/keystone/queens/install/)