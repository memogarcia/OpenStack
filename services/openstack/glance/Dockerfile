FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN wget https://raw.githubusercontent.com/openstack/requirements/stable/queens/upper-constraints.txt -O /opt/upper-constraints.txt && \
    mkdir /etc/glance && \
    git clone -b stable/queens --depth=1 https://github.com/openstack/glance.git /opt/glance

WORKDIR /opt/glance

RUN pip2 install -c /opt/upper-constraints.txt -e . && tox -e genconfig

VOLUME ["/var/log/glance", "/var/lib/glance"]

EXPOSE 9292 9191
