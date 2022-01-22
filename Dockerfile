# Apache HTTPD server based on openSUSE Leap 15.3
FROM ghcr.io/fab-infra/apache:2.4-opensuse15 as apache

# PHP based on openSUSE Leap 15.3
FROM ghcr.io/fab-infra/php-cli:7.4-opensuse15

# Arguments
ARG HTTPD_MPM="prefork"
ARG HTTPD_MODULES="access_compat authnz_ldap deflate filter headers http2 ldap php7 proxy proxy_ajp proxy_balancer proxy_fcgi proxy_http proxy_wstunnel remoteip rewrite slotmem_shm status version vhost_alias"
ARG HTTPD_FLAGS=""

# Apache HTTPD with mod_php
RUN zypper in -y apache2 \
	apache2-prefork \
	apache2-mod_php7 \
	apache2-icons-oxygen \
	apache2-utils &&\
	zypper clean -a

# Configuration
COPY --from=apache /etc/apache2/ /etc/apache2/
COPY --from=apache /etc/confd/ /etc/confd/
RUN sysconf_addword /etc/sysconfig/apache2 APACHE_MPM ${HTTPD_MPM} &&\
	for MODULE in ${HTTPD_MODULES}; do a2enmod $MODULE; done &&\
	for FLAG in ${HTTPD_FLAGS}; do a2enflag $FLAG; done

# Files
COPY --from=apache /run.sh /run.sh
COPY --from=apache /srv/www/htdocs/ /srv/www/htdocs/
COPY ./root /
RUN chmod -R a+rwX /etc/apache2 /var/log/apache2 /var/run &&\
	chmod +x /usr/sbin/start_apache2

# Ports
EXPOSE 8080
