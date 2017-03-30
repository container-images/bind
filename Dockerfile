FROM fedora:25

# Description
# Exposed ports:
# * 53 - domain name system

MAINTAINER Rado Pitonak <rpitonak@redhat.com>

LABEL summary = "Bind is a Domain Name System(DNS) resolver and server." \
      name = "dns-bind" \
      version = "9" \
      release = "0.1" \
      description = "Bind enables you to publish your DNS information on the Internet, and to resolve DNS queries for your users"
      vendor="Fedora Project" \
      org.fedoraproject.component="dns-bind" \
      authoritative-source-url="registry.fedoraproject.org" \
      io.k8s.description="Bind enables you to publish your DNS information on the Internet, and to resolve DNS queries for your users" \
      io.k8s.display-name="dns-bind" \
      io.openshift.tags="dns-bind, bind, dns"


# install bind service and helper services to generate configuration files for DNS server
RUN dnf install -y --setopt=tsflags=nodocs bind initscripts python-mako PyYAML && \
    dnf -y clean all

ADD files /files

RUN /files/bind-config.sh

EXPOSE 53

CMD bin/sh /files/run-script.sh
