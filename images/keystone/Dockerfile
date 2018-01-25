FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/keystone

RUN git clone --depth=1 -b stable/pike https://github.com/openstack/keystone.git /opt/keystone

WORKDIR /opt/keystone

# RUN pacman -S --noconfirm nginx

RUN pacman -S --noconfirm python2

RUN pacman -S --noconfirm python2-pip python2-setuptools

RUN pacman -S --noconfirm python2-netifaces gcc-libs

RUN ["ln", "-sf", "python", "python2"]

RUN pacman -S --noconfirm wget

RUN wget http://ftp5.gwdg.de/pub/linux/archlinux/core/os/x86_64//mpfr-4.0.0-1-x86_64.pkg.tar.xz

RUN pacman -U  --noconfirm mpfr-4.0.0-1-x86_64.pkg.tar.xz

RUN ["python2", "-m", "pip", "install", "-e", "."]

RUN pip install tox

RUN tox -e genconfig

# COPY configparse.py configparse.py
# COPY configure.sh configure.sh
COPY start.sh start.sh

# RUN ["chmod", "a+x", "configure.sh"]
RUN ["chmod", "a+x", "start.sh"]

# RUN ["./configure.sh"]

COPY keystone-paste.ini /etc/keystone/keystone-paste.ini
COPY keystone.conf /etc/keystone/keystone.conf
# RUN ["python", "configparse.py"]
# RUN ["./init-user-db.sh"]

VOLUME ["/var/log/keystone"]

EXPOSE 35357
EXPOSE 5000

RUN python2 -m pip install psycopg2

CMD ["./start.sh"]