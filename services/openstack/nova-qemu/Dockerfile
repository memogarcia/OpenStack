FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN pacman -Sy --noconfirm libvirt-python \
                            sysfsutils \
                            libvirt \
                            qemu && \
    mkdir /etc/nova /etc/nova/rootwrap.d/ && \
    git clone -b stable/queens --depth=1 https://github.com/openstack/nova.git /opt/nova && \
    mkdir /opt/nova/instances && \
    wget https://raw.githubusercontent.com/openstack/requirements/stable/queens/upper-constraints.txt -O /opt/upper-constraints.txt

WORKDIR /opt/nova

RUN pip2 install -c /opt/upper-constraints.txt -e . && tox -e genconfig && pip2 install libvirt-python

VOLUME  ["/var/log/nova"]

EXPOSE 8775

COPY start.sh /opt/start.sh

COPY supervisord.conf /etc/supervisord.conf

COPY config/ /opt/config/

CMD ["bash", "/opt/start.sh"]
