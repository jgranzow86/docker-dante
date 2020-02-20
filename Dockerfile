FROM centos:7
LABEL email="jason.granzow@gmail.com"

COPY entrypoint.sh /sbin/entrypoint.sh
COPY ./tgz-prod.dante-1.4.2-rhel72-amd64-64bit-gcc.tar.gz /tgz-prod.dante-1.4.2-rhel72-amd64-64bit-gcc.tar.gz

RUN ls -lh / \
	&& tar -xvzf /tgz-prod.dante-1.4.2-rhel72-amd64-64bit-gcc.tar.gz -C / \
	&& useradd socks \
	&& chmod 755 /sbin/entrypoint.sh

EXPOSE 1080/tcp 1080/udp
ENTRYPOINT ["/sbin/entrypoint.sh"]
#CMD ["/usr/sbin/named", "-c", "/etc/bind/named.conf", "-g", "-u", "named", "-4"]
