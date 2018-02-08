FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN pacman -S --noconfirm libvirt-python \
                            sysfsutils \
                            libvirt \
                            qemu

VOLUME  ["/var/log/nova"]

EXPOSE 8775

COPY config-nova-compute.json config-nova-compute.json
COPY config-nova.json config-nova.json

# RUN python2 /configparse.py --config config-nova.json --service "/etc/nova/nova.conf"
# RUN python2 /configparse.py --config config-nova-compute.json --service "/etc/nova/nova-compute.conf"

COPY start.sh start.sh
CMD ["bash", "start.sh"]