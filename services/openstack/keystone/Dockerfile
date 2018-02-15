FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/keystone && git clone -b stable/queens --depth=1 https://github.com/openstack/keystone.git /opt/keystone

WORKDIR /opt/keystone

RUN pip2 install -e . && tox -e genconfig

VOLUME ["/var/log/keystone"]

EXPOSE 35357 5000
