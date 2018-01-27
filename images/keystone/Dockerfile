FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/keystone

RUN git clone --depth=1 -b stable/pike https://github.com/openstack/keystone.git /opt/keystone

WORKDIR /opt/keystone

RUN python2 -m pip install -e .

RUN python2 -m pip install "pika<0.11,>=0.9"

RUN pacman -Sy --noconfirm apache mod_wsgi2

RUN tox -e genconfig

VOLUME ["/var/log/keystone"]

EXPOSE 35357
EXPOSE 5000

COPY wsgi-keystone.conf /etc/httpd/conf.d/wsgi-keystone.conf

COPY keystone-paste.ini /etc/keystone/keystone-paste.ini
COPY keystone.conf /etc/keystone/keystone.conf

RUN mkdir -p /etc/httpd/logs/
RUN mkdir -p /run/httpd/

COPY start.sh start.sh

RUN ["chmod", "a+x", "start.sh"]

CMD ["bash", "start.sh"]
