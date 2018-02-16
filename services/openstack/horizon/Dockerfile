FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/horizon && \
    git clone -b stable/queens --depth=1 https://github.com/openstack/horizon.git /opt/horizon

WORKDIR /opt/horizon

RUN pip2 install -e .

COPY start.sh /opt/start.sh

COPY supervisord.conf /etc/supervisord.conf

COPY config/ /opt/config/

CMD ["bash", "/opt/start.sh"]
