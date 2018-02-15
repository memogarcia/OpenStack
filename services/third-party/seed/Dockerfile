FROM shaddock/archlinux:latest

LABEL maintainer=root@memogarcia.mx

RUN pacman -Sy --noconfirm \
        gcc base-devel git gcc-libs wget \
        python2 python2-pip python2-setuptools python2-netifaces \
        wget supervisor nss nspr \
        mariadb-clients mysql-python \
        postgresql python-psycopg2

RUN wget http://ftp5.gwdg.de/pub/linux/archlinux/core/os/x86_64/mpfr-4.0.0-1-x86_64.pkg.tar.xz

RUN pacman -U --noconfirm mpfr-4.0.0-1-x86_64.pkg.tar.xz

RUN python2 -m pip install tox python-memcached pymysql python-openstackclient crudini

COPY configparse.py configparse.py

COPY osrc-v3 /opt/osrc-v3

ONBUILD COPY start.sh /opt/start.sh

ONBUILD COPY supervisord.conf /opt/supervisord.conf

ONBUILD COPY config/ /opt/config/

CMD ["bash", "/opt/start.sh"]