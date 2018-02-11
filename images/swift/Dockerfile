FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/swift

RUN git clone -b stable/pike --depth=1 https://github.com/openstack/swift.git /opt/swift

WORKDIR /opt/swift

RUN wget https://raw.githubusercontent.com/openstack/requirements/stable/pike/upper-constraints.txt

RUN pip2 install -c upper-constraints.txt -e . && tox -e genconfig

RUN pacman -Sy --noconfirm mariadb-clients mysql-python

RUN pip2 install pymysql python-openstackclient

COPY supervisord.conf /etc/supervisord.conf
COPY start.sh start.sh
CMD ["bash", "start.sh"]