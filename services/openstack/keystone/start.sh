#!/bin/bash
set -u

export PGPASSWORD=secret

echo "DB configuration"
mysql  -hopenstack_mariadb -uroot -psecret \
      -e "CREATE DATABASE keystone;"

mysql  -hopenstack_mariadb -uroot -psecret \
       -e "GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' \
          IDENTIFIED BY 'secret';"

mysql  -hopenstack_mariadb -uroot -psecret \
       -e "GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' \
          IDENTIFIED BY 'secret'"

echo "Sync keystone database"
keystone-manage db_sync

echo "Initialize fernet key repositories"
keystone-manage fernet_setup --keystone-user http --keystone-group http
keystone-manage credential_setup --keystone-user http --keystone-group http

echo "Bootstrap the service"
keystone-manage bootstrap \
  --bootstrap-password secret \
  --bootstrap-username admin \
  --bootstrap-project-name admin \
  --bootstrap-role-name admin \
  --bootstrap-service-name keystone \
  --bootstrap-region-id RegionOne \
  --bootstrap-admin-url http://openstack_keystone:35357/v3/ \
  --bootstrap-internal-url http://openstack_keystone:35357/v3/ \
  --bootstrap-public-url http://openstack_keystone:5000/v3/


keystone-manage bootstrap \
  --bootstrap-password secret \
  --bootstrap-project-name service

keystone-wsgi-admin --port 35357 --host 0.0.0.0 &
keystone-wsgi-public --port 5000 --host 0.0.0.0