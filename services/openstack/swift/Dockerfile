FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN git clone https://github.com/openstack/liberasurecode /opt/liberasurecode

WORKDIR /opt/liberasurecode

RUN bash autogen.sh &&  bash configure && make && make install

RUN mkdir /etc/swift

RUN mkdir /etc/swift && \
    pacman -Sy --noconfirm xfsprogs rsync && \
    curl -o /etc/swift/proxy-server.conf https://git.openstack.org/cgit/openstack/swift/plain/etc/proxy-server.conf-sample?h=stable/queens && \
    git clone -b stable/queens --depth=1 https://github.com/openstack/swift.git /opt/swift && \
    wget https://raw.githubusercontent.com/openstack/requirements/stable/queens/upper-constraints.txt -O /opt/upper-constraints.txt

WORKDIR /opt/swift

RUN pip2 install -e . && \
    pip2 install keystonemiddleware

COPY templates/ld.so.conf /etc/ld.so.conf

COPY start.sh /opt/start.sh

COPY supervisord.conf /etc/supervisord.conf

COPY config/ /opt/config/

CMD ["bash", "/opt/start.sh"]
