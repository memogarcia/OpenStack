FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/neutron

RUN git clone -b stable/pike --depth=1 https://github.com/openstack/neutron.git /opt/neutron

WORKDIR /opt/neutron

RUN wget https://raw.githubusercontent.com/openstack/requirements/stable/pike/upper-constraints.txt

RUN pip2 install -c upper-constraints.txt -e . && tox -e genconfig

VOLUME ["/var/log/neutron"]

EXPOSE 9696

COPY config-metadata.json config-metadata.json

RUN ["cp", "/opt/glance/etc/glance-api.conf", "/etc/glance/glance-api.conf"]
RUN ["cp", "/opt/glance/etc/glance-api-paste.ini", "/etc/glance/glance-api-paste.ini"]
RUN ["cp", "/opt/glance/etc/glance-registry-paste.ini", "/etc/glance/glance-registry-paste.ini"]
RUN ["cp", "/opt/glance/etc/glance-registry.conf", "/etc/glance/glance-registry.conf"]
RUN ["cp", "/opt/glance/etc/glance-registry.conf", "/etc/glance/glance-registry.conf"]
RUN ["cp", "/opt/glance/etc/schema-image.json", "/etc/glance/schema-image.json"]
RUN ["cp", "/opt/glance/etc/policy.json", "/etc/glance/policy.json"]

RUN python2 /configparse.py --config config-metadata.json --service "/etc/neutron/metadata_agent.ini"

RUN pip2 pymysql

COPY start.sh start.sh
CMD ["bash", "start.sh"]