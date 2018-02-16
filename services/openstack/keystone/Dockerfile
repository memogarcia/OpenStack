FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN wget https://raw.githubusercontent.com/openstack/requirements/stable/queens/upper-constraints.txt -O /opt/upper-constraints.txt && \
    mkdir /etc/keystone && \
    git clone -b stable/queens --depth=1 https://github.com/openstack/keystone.git /opt/keystone

WORKDIR /opt/keystone

RUN pip2 install -c /opt/upper-constraints.txt -e . && tox -e genconfig

VOLUME ["/var/log/keystone"]

EXPOSE 35357 5000

COPY start.sh /opt/start.sh

COPY supervisord.conf /etc/supervisord.conf

COPY config/ /opt/config/

CMD ["bash", "/opt/start.sh"]
