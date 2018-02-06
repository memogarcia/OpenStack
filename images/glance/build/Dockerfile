FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/keystone

RUN git clone --depth=1 -b stable/pike https://github.com/openstack/glance.git /opt/glance

WORKDIR /opt/glance

RUN python2 -m pip install -e . && tox -e genconfig

VOLUME ["/var/log/glance", "/etc/glance/"]

COPY config-api.json config-api.json

RUN cp etc/glance-api.conf /etc/glance/glance-api.conf && cp etc/glance-api-paste.ini /etc/glance/glance-api-paste.ini && cp etc/glance-registry-paste.ini /etc/glance/glance-registry-paste.ini && cp etc/glance-registry.conf /etc/glance/glance-registry.conf

RUN python2 /configparse.py --config config-api.json --service "/etc/glance/glance-api.conf"
