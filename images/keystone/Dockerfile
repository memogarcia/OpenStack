FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN pacman -Sy --noconfirm python-pip gcc

RUN mkdir /etc/keystone

COPY configparse.py configparse.py
COPY configure.sh configure.sh
COPY start.sh start.sh

RUN ["chmod", "a+x", "configure.sh"]
RUN ["chmod", "a+x", "start.sh"]

RUN ["./configure.sh"]
RUN ["python", "configparse.py"]
# RUN ["./init-user-db.sh"]

VOLUME ["/var/log/keystone"]

EXPOSE 35357
EXPOSE 5000

CMD ["./start.sh"]