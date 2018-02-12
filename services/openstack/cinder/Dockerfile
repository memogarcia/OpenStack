FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/cinder /etc/cinder/rootwrap.d

RUN git clone -b stable/queens --depth=1 https://github.com/openstack/cinder.git /opt/cinder

WORKDIR /opt/cinder

RUN wget https://raw.githubusercontent.com/openstack/requirements/stable/queens/upper-constraints.txt

RUN pip2 install -c upper-constraints.txt -e . && tox -e genconfig

VOLUME ["/var/log/cinder", "/var/lib/cinder"]

EXPOSE 8776

COPY config.json config.json

RUN ["cp", "/opt/cinder/etc/cinder/api-httpd.conf", "/etc/cinder/api-httpd.conf"]
RUN ["cp", "/opt/cinder/etc/cinder/api-paste.ini", "/etc/cinder/api-paste.ini"]
RUN ["cp", "/opt/cinder/etc/cinder/logging_sample.conf", "/etc/cinder/logging.conf"]
RUN ["cp", "/opt/cinder/etc/cinder/resource_filters.json", "/etc/cinder/resource_filters.json"]
RUN ["cp", "/opt/cinder/etc/cinder/rootwrap.conf", "/etc/cinder/rootwrap.conf"]
RUN ["cp", "/opt/cinder/etc/cinder/rootwrap.d/volume.filters", "/etc/cinder/rootwrap.d/volume.filters"]

RUN python2 /configparse.py --config config.json --service "/etc/cinder/cinder.conf"

COPY supervisord.conf /etc/supervisord.conf
COPY start.sh start.sh
CMD ["bash", "start.sh"]