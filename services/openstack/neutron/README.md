# Neutron

## Configuration

Modify the following files to match your environment:

* [config/config.json](config/config.json) which will map to `/etc/neutron/neutron.conf`.
* [config/config-metadata.json](config/config-metadata.json) which will map to `/etc/neutron/metadata_agent.ini`
* [dev.yml](dev.yml) to match your host environment.

## Network configuration

Chose one network configuration to deploy on your environment

### Provider networks

Deploys the simplest configuration, in which you use [provider networks](https://docs.openstack.org/newton/install-guide-rdo/launch-instance-networks-provider.html) to attach instances to. This means:

* No private networks
* No virtual routers
* No Floating IPs
* Only `admin` users can modify and create networks

**Note** This option works with SDN's

Modify:

* [config/config-ml2.json](config/config-ml2.json) to map to `/etc/neutron/plugins/ml2/ml2_conf.ini`
* [config/config-linuxbridge-agent.json](config/config-linuxbridge-agent.json) to map to `/etc/neutron/plugins/ml2/linuxbridge_agent.ini`
* [config/config-dhcp-agent.json](config/config-dhcp-agent.json) to map to `/etc/neutron/dhcp_agent.ini`

Before the service is running, create a docker network that will act as a provider for neutron:

    docker network create openstack-provider-net \
        --driver=bridge \
        --subnet=172.28.0.0/16 \
        --ip-range=172.28.5.0/24 \
        --gateway=172.28.5.254

After the service is running, create a provider network with neutron:

    openstack network create --share --external \
        --provider-physical-network provider \
        --provider-network-type flat provider

And its subnet:

    openstack subnet create --network provider \
        --allocation-pool start=172.28.5.1,end=172.28.5.250 \
        --dns-nameserver 8.8.8.8 --gateway 172.28.5.254 \
        --subnet-range 172.28.0.0/16 provider-subnet

Create a port:

    openstack port create \
        --fixed-ip subnet=provider-subnet,ip-address=172.28.5.2 \
        --enable \
        --network provider \
        port-provider

### Self-service networks

Self-service configuration allows attaching instances to private networks (VxLans). This means:

* Private networks
* Virtual routers
* Floating IPs
* Non-admin users can modify and create networks
* Attach instances to provider networks

**Note** This option works with SDN's
**Note** Configuration steps are missing

## References

[Docker networking](https://docs.docker.com/engine/reference/commandline/network_create/#specify-advanced-options)
[Host networking](https://docs.openstack.org/neutron/pike/install/environment-networking-obs.html)
[Provider networks](https://docs.openstack.org/neutron/pike/install/controller-install-option1-obs.html)