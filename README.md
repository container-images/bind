Bind container image
====================

This repository contains Dockerfile for [BIND](https://www.isc.org/downloads/bind/) based on [baseruntime](""https://hub.docker.com/r/baseruntime/baseruntime/).
For more information about modules see official [Fedora Modularity documentation](docs.pagure.org/modularity/).


Configuration
----------------------------------

There are two options for running Bind DNS server:

### 1) Authoritative

Authoritative-only servers only respond to iterative queries for the zones that they are authoritative for. This means that if the server does not know the answer, it will just tell the client (usually some kind of resolving DNS server) that it does not know the answer and give a reference to a server that may know more.

Authoritative-only DNS servers are often a good configuration for high performance because they do not have the overhead of resolving recursive queries from clients. They only care about the zones that they are designed to serve.

Domains need to be set in [config.yaml](./files/authoritative-dns/config.yaml)

### 2) Caching (recursive)

This type of server is also known as a resolver because it handles recursive queries and generally can handle the grunt work of tracking down DNS data from other servers.

When a caching DNS server tracks down the answer to a client's query, it returns the answer to the client. But it also stores the answer in its cache for the period of time. The cache can then be used as a source for subsequent requests in order to speed up the total round-trip time.

Nameservers can be set in [config.yaml](./files/caching-dns/config.yaml)


Environment variables
----------------------------------   

|    Variable name                |    Description                                                     |    Default
| :------------------------------ | ------------------------------------------------------------------ | -------------------------------
|  `SERVER_TYPE`                  | Type of DNS server. The options are 'AUTHORITATIVE' and 'CACHING'. |  CACHING

Build
----------------------------------

Container image uses [distgen](https://github.com/devexp-db/distgen) to provide portability. To build the image, run:
```
$ make build
```
Build requires go-md2man for man page generation, use dnf(or another package manager) to istall it before building:
```
# dnf install go-md2man
```

Usage
----------------------------------

```
docker run -d -p 127.0.0.1:53:53 -p 127.0.0.1:53:53/udp -e SERVER_TYPE=<TYPE> modularitycontainers/bind
```
Substitute \<TYPE\> with either 'AUTHORITATIVE' or 'CACHING' option. If the option value is not provided, the default value is 'CACHING'.

Test
----------------------------------
This repository also provides tests (based on [MTF](https://github.com/fedora-modularity/meta-test-family)) which checks basic functionality of the bind image.

Run the tests using Makefile :
```
$ make test
```

Notes
----------------------------------

Note that the current version of the image talks to authoritative name
servers and therefore doesn't work in restricted environments.
