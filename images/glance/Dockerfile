FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/glance

RUN git clone --depth=1 -b stable/pike https://github.com/openstack/glance.git /opt/glance

WORKDIR /opt/glance

RUN python2 -m pip install -e . && tox -e genconfig

VOLUME ["/var/log/glance"]

EXPOSE 9292
EXPOSE 9191

COPY config-api.json config-api.json
COPY config-registry.json config-registry.json

RUN ["cp", "/opt/glance/etc/glance-api.conf", "/etc/glance/glance-api.conf"]
RUN ["cp", "/opt/glance/etc/glance-api-paste.ini", "/etc/glance/glance-api-paste.ini"]
RUN ["cp", "/opt/glance/etc/glance-registry-paste.ini", "/etc/glance/glance-registry-paste.ini"]
RUN ["cp", "/opt/glance/etc/glance-registry.conf", "/etc/glance/glance-registry.conf"]
RUN ["cp", "/opt/glance/etc/glance-registry.conf", "/etc/glance/glance-registry.conf"]
RUN ["cp", "/opt/glance/etc/schema-image.json", "/etc/glance/schema-image.json"]
RUN ["cp", "/opt/glance/etc/policy.json", "/etc/glance/policy.json"]

RUN python2 /configparse.py --config config-api.json --service "/etc/glance/glance-api.conf"
RUN python2 /configparse.py --config config-registry.json --service "/etc/glance/glance-registry.conf"

COPY start.sh start.sh
CMD ["bash", "start.sh"]