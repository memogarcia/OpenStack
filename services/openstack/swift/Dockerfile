FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /opt/lib

RUN git clone https://github.com/openstack/liberasurecode /opt/lib/

WORKDIR /opt/lib/liberasurecode

RUN ./autogen.sh &&  ./configure && make && make install

RUN mkdir /etc/swift

RUN git clone -b stable/queens --depth=1 https://github.com/openstack/swift.git /opt/swift

WORKDIR /opt/swift

RUN wget https://raw.githubusercontent.com/openstack/requirements/stable/queens/upper-constraints.txt

RUN pip2 install -c upper-constraints.txt -e . && tox -e genconfig

RUN pacman -Sy --noconfirm xfsprogs rsync

COPY supervisord.conf /etc/supervisord.conf
COPY start.sh start.sh
CMD ["bash", "start.sh"]