FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/glance

RUN git clone --depth=1 -b stable/pike https://github.com/openstack/glance.git /opt/glance

RUN pacman -S --noconfirm supervisor

WORKDIR /opt/glance

RUN python2 -m pip install -e .

VOLUME  ["/var/log/glance", "/var/lib/glance/images"]

EXPOSE 9292

COPY glance-api.conf /etc/glance/glance-api.conf
COPY glance-registry.conf /etc/glance/glance-registry.conf
COPY glance-api-paste.ini /etc/glance/glance-api-paste.ini
COPY glance-registry-paste.ini /etc/glance/glance-registry-paste.ini
COPY supervisord.conf supervisord.conf
COPY start.sh start.sh

RUN ["chmod", "a+x", "start.sh"]

# CMD ["bash", "start.sh"]