FROM glance_glance-build

VOLUME ["/var/log/keystone", "/etc/glance/"]

EXPOSE 9292

COPY start.sh start.sh
CMD ["bash", "start.sh"]