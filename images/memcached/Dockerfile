FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN pacman -Sy --noconfirm python2-memcached memcached

RUN useradd daemon

EXPOSE 11211

CMD ["memcached", "-d"]
