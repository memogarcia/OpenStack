FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/neutron && \
    mkdir -p /etc/neutron/plugins/ml2 && \
    wget https://raw.githubusercontent.com/openstack/requirements/stable/queens/upper-constraints.txt -O /opt/upper-constraints.txt && \
    git clone -b stable/queens --depth=1 https://github.com/openstack/neutron.git /opt/neutron

WORKDIR /opt/neutron

RUN pip2 install -c /opt/upper-constraints.txt -e . && tox -e genconfig

VOLUME ["/var/log/neutron"]

EXPOSE 9696
