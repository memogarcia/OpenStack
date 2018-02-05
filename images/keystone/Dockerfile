FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/keystone

RUN git clone --depth=1 -b stable/pike https://github.com/openstack/keystone.git /opt/keystone

WORKDIR /opt/keystone

RUN python2 -m pip install -e . && tox -e genconfig

RUN python2 -m pip install 'pika<0.11,>=0.9'

VOLUME ["/var/log/keystone"]

EXPOSE 35357
EXPOSE 5000

COPY configmerge.py configmerge.py
COPY start.sh start.sh
CMD ["bash", "start.sh"]
