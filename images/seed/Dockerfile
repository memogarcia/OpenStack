FROM base/archlinux:latest

LABEL maintainer=root@memogarcia.mx

RUN pacman -Sy --noconfirm \
        postgresql \
        python-psycopg2 \
        python-sqlalchemy \
        python-pip \
        gcc \
        base-devel \
        git

RUN pacman -S --noconfirm python-setuptools