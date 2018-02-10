FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/horizon

RUN git clone -b stable/pike --depth=1 https://github.com/openstack/horizon.git /opt/horizon

WORKDIR /opt/horizon

RUN pip2 install -c http://git.openstack.org/cgit/openstack/requirements/plain/upper-constraints.txt?h=stable/pike .

COPY local_settings.py.sample /opt/horizon/openstack_dashboard/local/local_settings.py

COPY start.sh start.sh
CMD ["bash", "start.sh"]