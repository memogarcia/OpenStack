FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/nova /etc/nova/rootwrap.d/ && \
    mkdir -p /etc/neutron/plugins/ml2/ && \
    wget https://raw.githubusercontent.com/openstack/requirements/stable/queens/upper-constraints.txt -O /opt/upper-constraints.txt && \
    git clone -b stable/queens --depth=1 https://github.com/openstack/nova.git /opt/nova

WORKDIR /opt/nova

RUN pip2 install -c /opt/upper-constraints.txt -e . && tox -e genconfig

RUN pacman -Sy --noconfirm iptables net-tools && \
    git clone https://github.com/kanaka/noVNC /usr/share/novnc && \
    ln -s /noVNC/utils/launch.sh /usr/share/novnc && \
    ln -s /usr/share/novnc/utils/launch.sh /usr/bin/novnc

VOLUME ["/var/log/nova"]

EXPOSE 8774 8778

COPY start.sh /opt/start.sh

COPY supervisord.conf /etc/supervisord.conf

COPY config/ /opt/config/

CMD ["bash", "/opt/start.sh"]
