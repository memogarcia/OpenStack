FROM shaddock/archlinux:latest

LABEL maintainer=root@memogarcia.mx

RUN pacman -Sy --noconfirm \
        python-sqlalchemy \
        gcc \
        base-devel \
        git \
        python2 python2-pip python2-setuptools \
        python2-netifaces gcc-libs \
        wget \
        supervisor \
        mariadb-clients \
        mysql-python

RUN wget http://ftp5.gwdg.de/pub/linux/archlinux/core/os/x86_64//mpfr-4.0.0-1-x86_64.pkg.tar.xz

RUN pacman -U  --noconfirm mpfr-4.0.0-1-x86_64.pkg.tar.xz

RUN python2 -m pip install tox python-memcached

COPY configparse.py configparse.py

COPY osrc-v3 /opt/osrc-v3

RUN python2 -m pip install python-openstackclient crudini

RUN wget https://raw.githubusercontent.com/openstack/requirements/master/upper-constraints.txt

RUN pip2 install -r upper-constraints.txt