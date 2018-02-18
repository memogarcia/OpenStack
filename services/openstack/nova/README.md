# Nova

## Components

[nova-compute](https://docs.openstack.org/nova/latest/cli/nova-compute.html) is a server daemon that serves the Nova Compute service, which is responsible for building a disk image, launching an instance via the underlying virtualization driver, responding to calls to check the instance’s state, attaching persistent storage, and terminating the instance.

[nova-api](https://docs.openstack.org/nova/latest/cli/nova-api.html) is a server daemon that serves the metadata and compute APIs in separate greenthreads.

[nova-status](https://docs.openstack.org/nova/latest/cli/nova-status.html) is a tool that provides routines for checking the status of a Nova deployment.

[nova-manage](https://docs.openstack.org/nova/latest/cli/nova-manage.html) controls cloud computing instances by managing various admin-only aspects of Nova.

[nova-metadata](https://docs.openstack.org/nova/latest/cli/nova-api-metadata.html) is a server daemon that serves the Nova Metadata API (metadata server)

[nova-scheduler](https://docs.openstack.org/nova/latest/cli/nova-scheduler.html) is a server daemon that serves the Nova Scheduler service, which is responsible for picking a compute node to run a given instance on.

[nova-novncproxy](https://docs.openstack.org/nova/latest/cli/nova-novncproxy.html) is a server daemon that serves the Nova noVNC Websocket Proxy service

[nova-xvpvncproxy](hhttps://docs.openstack.org/nova/latest/cli/nova-xvpvncproxy.html) is a server daemon that serves the Nova XVP VNC Console Proxy service, which provides an XVP-based VNC Console Proxy for use with the Xen hypervisor.

[nova-serialproxy](https://docs.openstack.org/nova/latest/cli/nova-serialproxy.html) is a server daemon that serves the Nova Serial Websocket Proxy service, which provides a websocket proxy that is compatible with OpenStack Nova serial ports.

[nova-spicehtml5proxy](https://docs.openstack.org/nova/latest/cli/nova-serialproxy.html)  is a server daemon that serves the Nova SPICE HTML5 Websocket Proxy service, which provides a websocket proxy that is compatible with OpenStack Nova SPICE HTML5 consoles.

[nova-api-os-compute](https://docs.openstack.org/nova/latest/cli/nova-api-os-compute.html) is a server daemon that serves the Nova OpenStack Compute API.

[nova-rootwrap](https://docs.openstack.org/nova/latest/cli/nova-rootwrap.html) is an application that filters which commands nova is allowed to run as another user.

[nova-cells](https://docs.openstack.org/nova/latest/cli/nova-cells.html) handles communication between cells and selects cells for new instances.

[nova-dhcpbridge](https://docs.openstack.org/nova/latest/cli/nova-dhcpbridge.html) is an application that handles lease database updates from DHCP servers. nova-dhcpbridge is used whenever nova is managing DHCP (vlan and flatDHCP). nova-dhcpbridge should not be run as a daemon.

[nova-consoleauth](https://docs.openstack.org/nova/latest/cli/nova-consoleauth.html)  is a server daemon that serves the Nova Console Auth service, which provides authentication for Nova consoles.

[nova-console](https://docs.openstack.org/nova/latest/cli/nova-console.html) is a server daemon that serves the Nova Console service, which is a console proxy to set up multi-tenant VM console access, e.g. with XVP.

[nova-conductor](https://docs.openstack.org/nova/latest/cli/nova-conductor.html) is a server daemon that serves the Nova Conductor service, which provides coordination and database query support for Nova.

## Configuration

After the service is running, create a flavor:

    openstack flavor create a1.tiny --id auto --ram 64 --disk 1 --vcpus 1

Start an instance:

    openstack server create --flavor a1.tiny --nic port-id=55a80b9f-d251-414f-8108-8529e02f8332 --image cirros --security-group default vPoldeweg1

Verify is running:

    openstack server list

## References

[Command-line Utilities](https://docs.openstack.org/nova/latest/cli/index.html)