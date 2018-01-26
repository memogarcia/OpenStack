FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/keystone

RUN git clone --depth=1 -b stable/pike https://github.com/openstack/keystone.git /opt/keystone

WORKDIR /opt/keystone

RUN pacman -S --noconfirm nginx

RUN ln -sf python python2

RUN python2 -m pip install -e .

RUN python2 -m pip install tox psycopg2

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

CMD ["./start.sh"]