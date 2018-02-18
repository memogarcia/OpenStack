# MariaDB/MySQL

MariaDB/MySQL is the default database for OpenStack

## Configuration

By default, MariaDB uses the default configuration from [dev.yml](dev.yml). Of course, this can be updated.

For the database configuration, modify [start.sh](start.sh) to match your database.
In this environment, MariaDB is already configured.

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

## Starting the DB

    docker-compose -f dev.yml up