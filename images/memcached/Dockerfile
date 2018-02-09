FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN pacman -Sy --noconfirm memcached

EXPOSE 11211

CMD ["memcached", "-d"]
