# OpenVSwitch

## Configuration

Install openvswitch:

    pacman -Sy openvswitch
    systemctl enable ovs-vswitchd.service
    systemctl start ovs-vswitchd.service
    ovs-vsctl show

Configure the bridge:

    ovs-vsctl add-br ovs-br0

## References

[ovs](http://www.openvswitch.org)
[OpenvSwitch for libvirt on Arch Linux](https://ninefinity.org/post/openvswitch-for-libvirt-on-arch-linux/)