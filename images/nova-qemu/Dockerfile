FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN pacman -S --noconfirm libvirt-python \
                            sysfsutils \
                            libvirt \
                            qemu

RUN git clone --depth=1 -b stable/pike https://github.com/openstack/nova.git /opt/nova

WORKDIR /opt/nova

RUN python2 -m pip install -e . && tox -e genconfig

RUN mkdir /etc/nova

VOLUME  ["/var/log/nova"]

EXPOSE 8775

COPY config-nova-compute.json config-nova-compute.json
COPY config-nova.json config-nova.json

RUN mkdir /etc/nova/rootwrap.d/

RUN ["cp", "/opt/nova/etc/nova/api-paste.ini", "/etc/nova/api-paste.ini"]
RUN ["cp", "/opt/nova/etc/nova/cells.json", "/etc/nova/cells.json"]
RUN ["cp", "/opt/nova/etc/nova/logging_sample.conf", "/etc/nova/logging.conf"]
RUN ["cp", "/opt/nova/etc/nova/nova-config-generator.conf", "/etc/nova/nova-config-generator.conf"]
RUN ["cp", "/opt/nova/etc/nova/nova-policy-generator.conf", "/etc/nova/nova-policy-generator.conf"]
RUN ["cp", "/opt/nova/etc/nova/rootwrap.conf", "/etc/nova/rootwrap.conf"]
RUN ["cp", "/opt/nova/etc/nova/rootwrap.d/api-metadata.filters", "/etc/nova/rootwrap.d/api-metadata.filters"]
RUN ["cp", "/opt/nova/etc/nova/rootwrap.d/compute.filters", "/etc/nova/rootwrap.d/compute.filters"]
RUN ["cp", "/opt/nova/etc/nova/rootwrap.d/network.filters", "/etc/nova/rootwrap.d/network.filters"]

RUN python2 /configparse.py --config config-nova.json --service "/etc/nova/nova.conf"
RUN python2 /configparse.py --config config-nova-compute.json --service "/etc/nova/nova-compute.conf"

RUN rm /opt/nova/nova/db/sqlalchemy/api.py && wget https://gist.githubusercontent.com/memogarcia/e0c44badaf9edb4eb83359548 -O /opt/nova/nova/db/sqlalchemy/api.py
RUN rm /opt/nova/nova/virt/libvirt/driver.py && wget https://gist.githubusercontent.com/memogarcia/46b9a2466c9d85a213dc739389e384f9/raw/c1ddd14ede8e4413d839f212e86496b084e3186c/driver.py -O /opt/nova/nova/virt/libvirt/driver.py

VOLUME ["/var/lib/libvirt"]

COPY start.sh start.sh
CMD ["bash", "start.sh"]