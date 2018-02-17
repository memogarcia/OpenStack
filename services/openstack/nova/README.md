# Nova

## Components

[nova-metadata](https://docs.openstack.org/nova/latest/cli/nova-api-metadata.html) is a server daemon that serves the Nova Metadata API (metadata server)

[nova-novncproxy](https://docs.openstack.org/nova/latest/cli/nova-novncproxy.html) is a server daemon that serves the Nova noVNC Websocket Proxy service

## Configuration

After the service is running, create a flavor:

    openstack flavor create a1.tiny --id auto --ram 64 --disk 1 --vcpus 1

Start an instance:

    openstack server create --flavor a1.tiny --nic port-id=55a80b9f-d251-414f-8108-8529e02f8332 --image cirros --security-group default vPoldeweg1

Verify is running:

    openstack server list
