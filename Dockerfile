FROM registry.fedoraproject.org/fedora:25

# Description
# Exposed ports:
# * 53 - domain name system

MAINTAINER Rado Pitonak <rpitonak@redhat.com>

ENV NAME=dns-bind \
    VERSION=0 \
    RELEASE=1 \
    ARCH=x86_64

LABEL summary = "Bind is a Domain Name System (DNS) resolver and server." \
      name = "$FGC/$NAME" \
      version = "$VERSION" \
      release="$RELEASE.$DISTTAG"  \
      architecture = "$ARCH" \
      description = "Bind enables you to publish your DNS information on the Internet, and to resolve DNS queries for your users" \
      vendor="Fedora Project" \
      com.redhat.component="$NAME" \
      org.fedoraproject.component="dns-bind" \
      authoritative-source-url="registry.fedoraproject.org" \
      usage="docker run -d -p 127.0.0.1:53:53 -p 127.0.0.1:53:53/udp -e SERVER_TYPE=<TYPE> modularitycontainers/dns-bind" \
      io.k8s.description="Bind enables you to publish your DNS information on the Internet, and to resolve DNS queries for your users" \
      io.k8s.display-name="DNS Bind 9" \
      io.openshift.tags="dns-bind, bind, dns" \
      io.openshift.expose-services="53:domain name system"


# install bind service and helper services to generate configuration files for DNS server
RUN dnf install -y --setopt=tsflags=nodocs bind initscripts python-mako PyYAML && \
    dnf -y clean all

ADD files /files

# add help file
ADD root/help.1 /

RUN /files/bind-config.sh

EXPOSE 53

CMD bin/sh /files/run-script.sh
