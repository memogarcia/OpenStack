FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN git clone https://github.com/openstack/liberasurecode /opt/liberasurecode

WORKDIR /opt/liberasurecode

RUN bash autogen.sh &&  bash configure && make && make install

RUN mkdir /etc/swift

RUN git clone -b stable/queens --depth=1 https://github.com/openstack/swift.git /opt/swift

WORKDIR /opt/swift

# RUN curl -o /etc/swift/proxy-server.conf https://git.openstack.org/cgit/openstack/swift/plain/etc/proxy-server.conf-sample?h=stable/queens

RUN pip2 install -e .

RUN pacman -Sy --noconfirm xfsprogs rsync

RUN ["cp", "/opt/swift/etc/account-server.conf-sample", "/etc/swift/account-server.conf"]
RUN ["cp", "/opt/swift/etc/container-reconciler.conf-sample	", "/etc/swift/container-reconciler.conf"]
RUN ["cp", "/opt/swift/etc/container-server.conf-sample", "/etc/swift/container-server.conf"]
RUN ["cp", "/opt/swift/etc/container-sync-realms.conf-sample", "/etc/swift/container-sync-realms.conf"]
RUN ["cp", "/opt/swift/etc/dispersion.conf-sample", "/etc/swift/dispersion.conf"]
RUN ["cp", "/opt/swift/etc/internal-client.conf-sample", "/etc/swift/internal-client.conf"]
RUN ["cp", "/opt/swift/etc/keymaster.conf-sample", "/etc/swift/keymaster.conf"]
RUN ["cp", "/opt/swift/etc/memcache.conf-sample", "/etc/swift/memcache.conf"]
RUN ["cp", "/opt/swift/etc/mime.types-sample", "/etc/swift/mime.types"]
RUN ["cp", "/opt/swift/etc/object-expirer.conf-sample", "/etc/swift/object-expirer.conf-sample"]
RUN ["cp", "/opt/swift/etc/object-server.conf-sample", "/etc/swift/object-server.conf-sample"]
RUN ["cp", "/opt/swift/etc/proxy-server.conf-sample", "/etc/swift/proxy-server.conf-sample"]
RUN ["cp", "/opt/swift/etc/rsyncd.conf-sample", "/etc/swift/rsyncd.conf-sample"]
RUN ["cp", "/opt/swift/etc/rsyncd.conf-sample", "/etc/swift/rsyncd.conf-sample"]
RUN ["cp", "/opt/swift/etc/swift-rsyslog.conf-sample", "/etc/swift/swift-rsyslog.conf-sample"]
RUN ["cp", "/opt/swift/etc/swift.conf-sample", "/etc/swift/swift.conf-sample"]

RUN curl -o /etc/swift/proxy-server.conf https://git.openstack.org/cgit/openstack/swift/plain/etc/proxy-server.conf-sample?h=stable/queens

COPY config.json config.json
COPY config-proxy.json config-proxy.json

RUN python2 /configparse.py --config config-proxy.json --service "/etc/swift/proxy-server.conf"
RUN python2 /configparse.py --config config.json --service "/etc/swift/swift.conf"

COPY templates/ld.so.conf /etc/ld.so.conf

RUN ldconfig

COPY supervisord.conf /etc/supervisord.conf
COPY start.sh start.sh
CMD ["bash", "start.sh"]