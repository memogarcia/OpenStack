FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/keystone

RUN git clone -b stable/queens --depth=1 https://github.com/openstack/keystone.git /opt/keystone

WORKDIR /opt/keystone

RUN wget https://raw.githubusercontent.com/openstack/requirements/stable/queens/upper-constraints.txt

RUN pip2 install -c upper-constraints.txt -e . && tox -e genconfig

VOLUME ["/var/log/keystone"]

EXPOSE 35357
EXPOSE 5000

RUN ["cp", "/opt/keystone/etc/keystone.conf.sample", "/etc/keystone/keystone.conf"]
RUN ["cp", "/opt/keystone/etc/keystone-paste.ini", "/etc/keystone/keystone-paste.ini"]
RUN ["cp", "/opt/keystone/etc/logging.conf.sample", "/etc/keystone/logging.conf"]

COPY config.json config.json
RUN python2 /configparse.py --config config.json --service "/etc/keystone/keystone.conf"

RUN pacman -Sy --noconfirm mariadb-clients mysql-python
RUN pip2 install pymysql python-openstackclient

COPY supervisord.conf /etc/supervisord.conf
COPY start.sh start.sh
CMD ["bash", "start.sh"]
