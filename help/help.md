% {{ spec.envvars.name }} (1) Container Image Pages
% {{ spec.maintainer }}
% June 22, 2017

# NAME
{{ spec.envvars.name }} - {{ spec.description }}

# DESCRIPTION
This container image provides the Domain Name System (DNS) resolver and server. It uses Base runtime as a base image with Bind installed as a module.

# USAGE
You can run this image in docker like this:

      # docker run -d -p 127.0.0.1:53:53 -p 127.0.0.1:53:53/udp -e SERVER_TYPE=<TYPE> modularitycontainers/bind

Substitute \<TYPE\> with either 'AUTHORITATIVE' or 'CACHING' option. If the option value is not provided, the default value is 'CACHING'.

{{ spec.distro_specific_help }}

There are two options for running DNS server:

## 1) Authoritative

Authoritative-only servers only respond to iterative queries for the zones that they are authoritative for. This means that if the server does not know the answer, it will just tell the client (usually some kind of resolving DNS server) that it does not know the answer and give a reference to a server that may know more.

Authoritative-only DNS servers are often a good configuration for high performance because they do not have the overhead of resolving recursive queries from clients. They only care about the zones that they are designed to serve.

Domains need to be set in [config.yaml](./files/authoritative-dns/config.yaml)

## 2) Caching (recursive)

This type of server is also known as a resolver because it handles recursive queries and generally can handle the grunt work of tracking down DNS data from other servers.

When a caching DNS server tracks down the answer to a client's query, it returns the answer to the client. But it also stores the answer in its cache for the period of time. The cache can then be used as a source for subsequent requests in order to speed up the total round-trip time.

Nameservers can be set in [config.yaml](./files/caching-dns/config.yaml)

Image can also be run in Openshift. You can obtain the template in the repository of this image - https://github.com/container-images/bind. You also need to have SCC RunAsUser set to RunAsAny. Then run:

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
Github page for this container with detailed description: https://github.com/container-images/bind
