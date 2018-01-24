#!/bin/bash

# Clone the repo
git clone --depth=1 -b stable/pike https://github.com/openstack/keystone.git /opt/keystone

cd /opt/keystone
pip install -e .

tox -e genconfig
