FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/cinder /etc/cinder/rootwrap.d && \
    mkdir /etc/cinder && \
    git clone -b stable/queens --depth=1 https://github.com/openstack/cinder.git /opt/cinder

WORKDIR /opt/cinder

RUN pip2 install -c /opt/upper-constraints.txt -e . && tox -e genconfig

VOLUME ["/var/log/cinder", "/var/lib/cinder"]

EXPOSE 8776

COPY start.sh /opt/start.sh

COPY supervisord.conf /etc/supervisord.conf

COPY config/ /opt/config/

CMD ["bash", "/opt/start.sh"]
