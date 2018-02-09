FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/nova /etc/nova/rootwrap.d/

RUN git clone -b stable/pike --depth=1 https://github.com/openstack/nova.git /opt/nova

WORKDIR /opt/nova

RUN python2 -m pip install -e . && tox -e genconfig

RUN pacman -Sy --noconfirm iptables git net-tools

RUN git clone https://github.com/kanaka/noVNC /usr/share/novnc &&\
    ln -s /noVNC/utils/launch.sh /usr/share/novnc &&\
    ln -s /usr/share/novnc/utils/launch.sh /usr/bin/novnc

VOLUME ["/var/log/nova"]

EXPOSE 8774
# EXPOSE 8775
EXPOSE 8776
EXPOSE 8778

# RUN ["cp", "/opt/nova/etc/nova/nova.conf", "/etc/nova/nova.conf"]
RUN ["cp", "/opt/nova/etc/nova/api-paste.ini", "/etc/nova/api-paste.ini"]
RUN ["cp", "/opt/nova/etc/nova/cells.json", "/etc/nova/cells.json"]
RUN ["cp", "/opt/nova/etc/nova/logging_sample.conf", "/etc/nova/logging.conf"]
RUN ["cp", "/opt/nova/etc/nova/nova-config-generator.conf", "/etc/nova/nova-config-generator.conf"]
RUN ["cp", "/opt/nova/etc/nova/nova-policy-generator.conf", "/etc/nova/nova-policy-generator.conf"]
RUN ["cp", "/opt/nova/etc/nova/rootwrap.conf", "/etc/nova/rootwrap.conf"]
RUN ["cp", "/opt/nova/etc/nova/rootwrap.d/api-metadata.filters", "/etc/nova/rootwrap.d/api-metadata.filters"]
RUN ["cp", "/opt/nova/etc/nova/rootwrap.d/compute.filters", "/etc/nova/rootwrap.d/compute.filters"]
RUN ["cp", "/opt/nova/etc/nova/rootwrap.d/network.filters", "/etc/nova/rootwrap.d/network.filters"]

COPY config-nova.json config-nova.json

RUN python2 /configparse.py --config config-nova.json --service "/etc/nova/nova.conf"

RUN pacman -S --noconfirm mariadb-clients mysql-python

RUN pip2 install pymysql

# temporary patch for sqlalchemy/api.py in stable/pike
RUN rm /opt/nova/nova/db/sqlalchemy/api.py && wget https://gist.githubusercontent.com/memogarcia/e0c44badaf9edb4eb8335954837e1c39/raw/4e66294a89b8bb3459acabe9b2d6a271ab18900c/api.py -O /opt/nova/nova/db/sqlalchemy/api.py

COPY start.sh start.sh
CMD ["bash", "start.sh"]