FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/neutron

RUN git clone -b stable/queens --depth=1 https://github.com/openstack/neutron.git /opt/neutron

WORKDIR /opt/neutron

RUN wget https://raw.githubusercontent.com/openstack/requirements/stable/queens/upper-constraints.txt

RUN pip2 install -c upper-constraints.txt -e . && tox -e genconfig

VOLUME ["/var/log/neutron"]

EXPOSE 9696

RUN mkdir -p /etc/neutron/plugins/ml2

RUN ["cp", "/opt/neutron/etc/api-paste.ini", "/etc/neutron/api-paste.ini"]
RUN ["cp", "/opt/neutron/etc/policy.json", "/etc/neutron/policy.json"]
RUN ["cp", "/opt/neutron/etc/neutron/plugins/ml2/ml2_conf.ini.sample", "/etc/neutron/plugins/ml2/ml2_conf.ini"]

COPY config-metadata.json config-metadata.json
COPY config-dhcp-agent.json config-dhcp-agent.json
COPY config-linuxbridge-agent.json config-linuxbridge-agent.json
COPY config-ml2.json config-ml2.json
COPY config.json config.json

RUN python2 /configparse.py --config config-metadata.json --service "/etc/neutron/metadata_agent.ini"
RUN python2 /configparse.py --config config-dhcp-agent.json --service "/etc/neutron/dhcp_agent.ini"
RUN python2 /configparse.py --config config-linuxbridge-agent.json --service "/etc/neutron/plugins/ml2/linuxbridge_agent.ini"
RUN python2 /configparse.py --config config-ml2.json --service "/etc/neutron/plugins/ml2/ml2_conf.ini"
RUN python2 /configparse.py --config config.json --service "/etc/neutron/neutron.conf"

RUN pacman -Sy --noconfirm mariadb-clients mysql-python

RUN pip2 install pymysql python-openstackclient

COPY supervisord.conf /etc/supervisord.conf

# Opendaylight conf
RUN pacman -Sy --noconfirm openvswitch

COPY start.sh start.sh
CMD ["bash", "start.sh"]