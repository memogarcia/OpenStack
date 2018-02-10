FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/neutron

RUN git clone -b stable/pike --depth=1 https://github.com/openstack/neutron.git /opt/neutron

WORKDIR /opt/neutron

RUN wget https://raw.githubusercontent.com/openstack/requirements/stable/pike/upper-constraints.txt

RUN pip2 install -c upper-constraints.txt -e . && tox -e genconfig

VOLUME ["/var/log/neutron"]

EXPOSE 9696

COPY start.sh start.sh
CMD ["bash", "start.sh"]