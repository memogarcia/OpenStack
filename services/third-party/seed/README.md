# OpenStack docker base image

This is the Arch Linux base image for most of the docker containers.

It contains the following tools:

* gcc
* base-devel
* git
* gcc-libs
* wget
* python2
* python2-pip
* python2-setuptools
* python2-netifaces
* wget
* supervisor
* nss
* nspr
* mariadb-clients
* mysql-python
* postgresql
* python-psycopg2
* mpfr
* [configparse](configparse.py)

## Next steps

* Move the base image to alpine and make them as small as possible.
* Pulling openstack services from Arch repos (self-builded) instead from git should reduce dependencies and space
* Moving to python3.6
* Get rid of the 2 database tooling on the seed.
