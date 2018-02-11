FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN mkdir /etc/swift

RUN git clone -b stable/pike --depth=1 https://github.com/openstack/swift.git /opt/swift

WORKDIR /opt/swift

RUN wget https://raw.githubusercontent.com/openstack/requirements/stable/pike/upper-constraints.txt

RUN pip2 install -c upper-constraints.txt -e . && tox -e genconfig