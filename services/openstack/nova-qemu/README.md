# Nova-Qemu

From the perspective of the Compute service, the QEMU hypervisor is very similar to the KVM hypervisor. Both are controlled through libvirt, both support the same feature set, and all virtual machine images that are compatible with KVM are also compatible with QEMU. The main difference is that QEMU does not support native virtualization. Consequently, QEMU has worse performance than KVM and is a poor choice for a production deployment.

## Configuration

Before running the service, verify your [dev.yml](dev.yml):

```yml
    privileged: true
    volumes:
        - nova_log:/var/log/nova
        - libvirt_volume:/var/lib/libvirt/
        - /sys/fs/cgroup:/sys/fs/cgroup:rw
    devices:
        - "/dev/kvm:/dev/kvm"
```

After running the container, verify your virtualisation capabilities:

    egrep -c '(vmx|svm)' /proc/cpuinfo

The output should be >= 1

## References

[QEMU](https://docs.openstack.org/juno/config-reference/content/qemu.html)