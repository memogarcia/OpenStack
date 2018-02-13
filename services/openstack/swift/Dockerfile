FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN git clone https://github.com/openstack/liberasurecode /opt/liberasurecode

WORKDIR /opt/liberasurecode

RUN bash autogen.sh &&  bash configure && make && make install

RUN mkdir /etc/swift

RUN git clone -b stable/queens --depth=1 https://github.com/openstack/swift.git /opt/swift

WORKDIR /opt/swift

RUN curl -o /etc/swift/proxy-server.conf https://git.openstack.org/cgit/openstack/swift/plain/etc/proxy-server.conf-sample?h=stable/pike

RUN pip2 install -e . && tox -e genconfig

COPY config.json config.json

RUN python2 /configparse.py --config config.json --service "/etc/swift/proxy-server.conf"

RUN pacman -Sy --noconfirm xfsprogs rsync

COPY supervisord.conf /etc/supervisord.conf
COPY start.sh start.sh
CMD ["bash", "start.sh"]