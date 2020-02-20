FROM alpine:latest
LABEL email="jason.granzow@gmail.com"

COPY entrypoint.sh /sbin/entrypoint.sh

RUN 	set -x \
	# Runtime dependencies
	&& apk add --no-cache linux-pam \
	# Build dependencies
	&& apk add --no-cache -t .build-deps build-base curl linux-pam-dev \
	# Move to temp directory to download and compile
	&& cd /tmp \
	# Download and extract dante 'https://www.inet.no/dante/download.html'
	&& curl -L https://www.inet.no/dante/files/dante-1.4.2.tar.gz |tar -xzv \
	# Move into source folder
	&& cd dante-* \
	# Compile dante source
	&& ac_cv_func_sched_setscheduler=no ./configure \
	&& make install \
	# Clean up
	&& rm -rf /tmp/* \
	&& apk del --purge .build-deps \
	# add sockd user for dante to run as
        && adduser -S -D -u 8062 sockd \
	# edit entrypoint so it can be executed
	&& chmod 755 /sbin/entrypoint.sh

EXPOSE 1080/tcp 1080/udp
ENTRYPOINT ["/sbin/entrypoint.sh"]
