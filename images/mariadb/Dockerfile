FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN pacman -Sy --noconfirm mariadb mariadb-clients python
RUN useradd mysql

# Add VOLUMEs to allow backup of config and databases
VOLUME  ["/var/lib/mysql"]

EXPOSE 3306

COPY start.sh start.sh
CMD ["bash", "start.sh"]