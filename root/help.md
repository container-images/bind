% DNS-BIND (1) Container Image Pages
% Rado Pitonak
% June 22, 2017

# NAME
dns-bind - Bind is a Domain Name System (DNS) resolver and server.

# DESCRIPTION
This container image provides the Domain Name System (DNS) resolver and server. It uses Base runtime as a base image with Bind installed as a module.

# USAGE
You can run this image in docker like this:

      # docker run -d -p 127.0.0.1:53:53 -p 127.0.0.1:53:53/udp -e SERVER_TYPE=<TYPE> modularitycontainers/dns-bind

Substitute \<TYPE\> with either 'AUTHORITATIVE' or 'CACHING' option. If the option value is not provided, the default value is 'CACHING'.

There are two options for running DNS server:
 - Authoritative
    - you need set domains in /files/authoritative-dns/config.yaml
 - Caching (recursive)
    - you can set nameservers in /files/caching-dns/config.yaml

Image can also be run in Openshift. You can obtain the template in the repository of this image - https://github.com/container-images/dns-bind. You also need to have SCC RunAsUser set to RunAsAny. Then run:

	# oc create -f openshift-template.yml

# ENVIRONMENT VARIABLES
 `SERVER_TYPE`
  Type of DNS server. The options are 'AUTHORITATIVE' and 'CACHING'.
  Default: CACHING

# SECURITY IMPLICATIONS
-p $PORT:53
	Exposes port 53 on the container and forwards it to $PORT on the host. This is the Domain Name System (DNS) port.

This container runs as root user.

# HISTORY
Similar to a Changelog of sorts which can be as detailed as the maintainer wishes.

# SEE ALSO
Github page for this container with detailed description: https://github.com/container-images/dns-bind
