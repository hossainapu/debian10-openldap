FROM debian:10

EXPOSE 389

# runs as user openldap(104), group openldap(107)

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y wget build-essential systemd libdb-dev groff groff-base vim mlocate net-tools
RUN wget ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.50.tgz
RUN tar -xvzf openldap-2.4.50.tgz
RUN cd openldap-2.4.50 \
	&& ./configure --prefix=/usr/local \
	&& make depend \
	&& make \
	&& make install
RUN rm -rf openldap-2.4.50 openldap-2.4.50.tgz
COPY entrypoint /
RUN chmod 0755 /entrypoint	
RUN mkdir /usr/local/etc/slapd.d
COPY slapd.ldif /usr/local/etc/openldap/
RUN chmod 700 /usr/local/etc/openldap/slapd.ldif
RUN /usr/local/sbin/slapadd -n 0 -F /usr/local/etc/slapd.d -l /usr/local/etc/openldap/slapd.ldif
CMD ["/entrypoint"]
