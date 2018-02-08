FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/nova

RUN git clone --depth=1 -b stable/pike https://github.com/openstack/nova.git /opt/nova

WORKDIR /opt/nova

RUN python2 -m pip install -e . && tox -e genconfig
