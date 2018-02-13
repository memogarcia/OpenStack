FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN pacman -Sy --noconfirm openldap

COPY supervisord.conf supervisord.conf
COPY start.sh start.sh