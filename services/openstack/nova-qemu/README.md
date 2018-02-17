# Nova-Qemu

This service will deploy qemu instances.

## Configuration

Before running the service, verify your [dev.yml](dev.yml):

```yml
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