FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/keystone

RUN git clone --depth=1 https://github.com/openstack/keystone.git /opt/keystone

WORKDIR /opt/keystone

RUN python2 -m pip install -e . && tox -e genconfig

RUN python2 -m pip install 'pika<0.11,>=0.9'

VOLUME ["/var/log/keystone"]

EXPOSE 35357
EXPOSE 5000

RUN ["cp", "/opt/keystone/etc/keystone.conf.sample", "/opt/keystone/etc/keystone.conf"]
RUN ["cp", "/opt/keystone/etc/keystone-paste.ini", "/opt/keystone/etc/keystone-paste.ini"]
RUN ["cp", "/opt/keystone/etc/logging.conf.sample", "/etc/keystone/logging.conf"]

RUN python2 /configparse.py --config config.json --service "/etc/keystone/keystone.conf"

COPY start.sh start.sh
CMD ["bash", "start.sh"]
