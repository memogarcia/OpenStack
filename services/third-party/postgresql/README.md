# PostgreSQL

Because OpenStack uses sqlalchemy to deal with the DB, it's easy to swap databases.

## Configuration

For the database configuration, modify [model.yml](../../../model.yml) to match your database.

The `start.sh` script for each service will have a configuration like this:

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

And for `config/config.json`:

```bash
    ...
    "connection": "postgresql://keystone:secret@openstack_postgresql.openstack-management-net/keystone"
    ...
```
