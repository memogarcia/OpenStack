FROM shaddock/archlinux:latest

LABEL maintainer=root@memogarcia.mx

RUN pacman -Sy --noconfirm \
        postgresql \
        python-psycopg2 \
        python-sqlalchemy \
        python-pip \
        gcc \
        base-devel \
        git \
        python-setuptools \
        python2 python2-pip python2-setuptools \
        python2-netifaces gcc-libs \
        wget \
        supervisor

RUN wget http://ftp5.gwdg.de/pub/linux/archlinux/core/os/x86_64//mpfr-4.0.0-1-x86_64.pkg.tar.xz

RUN pacman -U  --noconfirm mpfr-4.0.0-1-x86_64.pkg.tar.xz

RUN python2 -m pip install tox psycopg2 python-memcached
