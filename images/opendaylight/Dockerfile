FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN pacman -Sy --noconfirm jre8-openjdk tar

RUN mkdir /opt/opendaylight

WORKDIR /opt/opendaylight

RUN wget https://nexus.opendaylight.org/content/repositories/public/org/opendaylight/integration/karaf/0.7.1/karaf-0.7.1.tar.gz

RUN tar -xvf karaf-0.7.1.tar.gz
