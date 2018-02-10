#!/bin/bash

set -u

echo "DB configuration"
mysql  -hopenstack_mariadb -umysql -psecret \
    -e "CREATE DATABASE neutron;"

mysql  -hopenstack_mariadb -umysql -psecret \
       -e "GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'localhost' \
        IDENTIFIED BY 'secret';"

mysql  -hopenstack_mariadb -umysql -psecret \
       -e "GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'%' \
        IDENTIFIED BY 'secret'"