FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN pacman -Sy --noconfirm libvirt-python \
                            sysfsutils \
                            libvirt \
                            qemu

RUN git clone -b stable/queens --depth=1 https://github.com/openstack/nova.git /opt/nova

WORKDIR /opt/nova

RUN wget https://raw.githubusercontent.com/openstack/requirements/stable/pike/upper-constraints.txt

RUN pip2 install -c upper-constraints.txt -e . && tox -e genconfig

RUN pip2 install libvirt-python

RUN mkdir /etc/nova /opt/nova/instances

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

RUN rm /opt/nova/nova/db/sqlalchemy/api.py && wget https://gist.githubusercontent.com/memogarcia/e0c44badaf9edb4eb8335954837e1c39/raw/4e66294a89b8bb3459acabe9b2d6a271ab18900c/api.py -O /opt/nova/nova/db/sqlalchemy/api.py
RUN rm /opt/nova/nova/virt/libvirt/driver.py && wget https://gist.githubusercontent.com/memogarcia/46b9a2466c9d85a213dc739389e384f9/raw/c1ddd14ede8e4413d839f212e86496b084e3186c/driver.py -O /opt/nova/nova/virt/libvirt/driver.py

# VOLUME ["/var/lib/libvirt"]

RUN pacman -Sy --noconfirm mariadb-clients mysql-python

RUN pip2 install pymysql python-openstackclient

COPY supervisord.conf /etc/supervisord.conf
COPY start.sh start.sh
CMD ["bash", "start.sh"]