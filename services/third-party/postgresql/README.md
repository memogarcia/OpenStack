# PostgreSQL

Because OpenStack uses sqlalchemy to deal with the DB, it's easy to swap databases.

## Configuration

For the database configuration, modify [start.sh](start.sh) file on each repo to match your database.
In this environment, MariaDB is configured. If you want to use PostgreSQL, replace the DB configuration
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

And for `config/config.json`:

```bash
    ...
    "connection": "postgresql://keystone:secret@openstack_postgresql.openstack-management-net/keystone"
    ...
```
