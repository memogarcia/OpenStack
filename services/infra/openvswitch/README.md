# OpenVSwitch

## Configuration

Install openvswitch:

    pacman -Sy openvswitch
    systemctl enable ovs-vswitchd.service
    systemctl start ovs-vswitchd.service
    ovs-vsctl show

Create a bridge file description in `/etc/netctl/br0`.

Modify this to match your environment:

```bash
Description="Virtual Bridge 0"
Interface=ovs-br0
Connection=openvswitch
BindsToInterfaces=eno1
IP=static
Address='10.42.14.100/16'
Gateway='10.42.0.254'
```

Configure the bridge:

    ovs-vsctl add-br ovs-br0
    systemctl start netctl@br0

## References

[ovs](http://www.openvswitch.org)
[OpenvSwitch for libvirt on Arch Linux](https://ninefinity.org/post/openvswitch-for-libvirt-on-arch-linux/)