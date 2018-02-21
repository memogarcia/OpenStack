# Glance

## Configuration

Modify the following files to match your environment:

* [config/config-api.json](config/config-api.json.j2) which will map to `/etc/glance/glance-api.conf`.
* [config/config-registry.json](config/config-registry.json.j2) which will map to `/etc/glance/glance-registry.conf`
* [dev.yml](dev.yml.j2) to match your host environment.

After the service is running, create an image:

    openstack image create --file cirros-0.4.0-x86_64-disk.img cirros

## References

[Glance installation Guide](https://docs.openstack.org/glance/queens/install/)