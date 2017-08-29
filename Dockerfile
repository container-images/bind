FROM {{ config.docker.from }}

# Description
# Exposed ports:
# * 53 - domain name system

MAINTAINER {{ spec.maintainer }}

ENV NAME={{ spec.envvars.name }} \
    VERSION={{ spec.envvars.version }} \
    RELEASE={{ spec.envvars.release }} \
    ARCH={{ spec.envvars.arch }}

LABEL summary = "Bind is a Domain Name System (DNS) resolver and server." \
      name = "$FGC/$NAME" \
      version = "$VERSION" \
      release="$RELEASE.$DISTTAG"  \
      architecture = "$ARCH" \
      description = "Bind enables you to publish your DNS information on the Internet, and to resolve DNS queries for your users" \
      vendor="{{ spec.vendor }}" \
      com.redhat.component="$NAME" \
      org.fedoraproject.component="bind" \
      authoritative-source-url="registry.fedoraproject.org" \
      usage="docker run -d -p 127.0.0.1:53:53 -p 127.0.0.1:53:53/udp -e SERVER_TYPE=<TYPE> modularitycontainers/bind" \
      io.k8s.description="Bind enables you to publish your DNS information on the Internet, and to resolve DNS queries for your users" \
      io.k8s.display-name="DNS Bind 9" \
      io.openshift.tags="bind, dns" \
      io.openshift.expose-services="{{ spec.expose }}:domain name system"

# install bind service and helper services to generate configuration files for DNS server
RUN {{ commands.pkginstaller.install(["bind", "bind-utils", "initscripts", "python-mako", "PyYAML"]) }} && \
    {{ commands.pkginstaller.cleancache() }}

ADD files /files

# add help file
# COPY root/help.1 /

RUN /files/bind-config.sh

EXPOSE {{ spec.expose }}

CMD ["/usr/sbin/named", "-u", "named", "-g"]
