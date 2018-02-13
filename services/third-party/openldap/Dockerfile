FROM openstack/seed:latest

LABEL maintainer=root@memogarcia.mx

RUN pacman -Sy --noconfirm openldap

EXPOSE 389
EXPOSE 636

VOLUME [ "/var/lib/glance" ]

RUN chown -R ldap:ldap /var/lib/ldap/

COPY templates/ templates/
COPY supervisord.conf supervisord.conf
COPY start.sh start.sh
CMD ["bash", "start.sh"]