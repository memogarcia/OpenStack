FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN pacman -Sy --noconfirm rabbitmq

# Define environment variables.
ENV RABBITMQ_LOG_BASE /data/log
ENV RABBITMQ_MNESIA_BASE /data/mnesia

VOLUME ["/data/log", "/data/mnesia"]

WORKDIR /data

EXPOSE 5672
EXPOSE 15672

COPY start.sh /start.sh
CMD ["bash", "/start.sh"]