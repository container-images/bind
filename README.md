Bind Docker image
====================

This repository contains Dockerfile for [BIND](https://www.isc.org/downloads/bind/) based on [baseruntime](""https://hub.docker.com/r/baseruntime/baseruntime/) for the Fedora 26 Boltron general usage.
For more information about modules see official [Fedora Modularity documentation](docs.pagure.org/modularity/).


Configuration
----------------------------------

There are two options for running DNS server:
 - Authoritative
    - you need set domains in [config.yaml](./files/authoritative-dns/config.yaml)
 - Caching (recursive)
    - you can set nameservers in [config.yaml](./files/caching-dns/config.yaml)


Environment variables
----------------------------------   

|    Variable name                |    Description                                                     |    Default
| :------------------------------ | ------------------------------------------------------------------ | -------------------------------
|  `SERVER_TYPE`                  | Type of DNS server. The options are 'AUTHORITATIVE' and 'CACHING'. |  CACHING

Usage
----------------------------------

```
docker run -d -p 127.0.0.1:53:53 -p 127.0.0.1:53:53/udp -e SERVER_TYPE=<TYPE> modularitycontainers/dns-bind
```
Substitute \<TYPE\> with either 'AUTHORITATIVE' or 'CACHING' option. If the option value is not provided, the default value is 'CACHING'.

Test
----------------------------------
This repository also provides tests (based on [MTF](https://pagure.io/modularity-testing-framework/tree/master)) which checks basic functionality of the DNS-BIND image.

Run the tests using Makefile :
```
$ make test
```


Notes
----------------------------------

Note that the current version of the image talks to authoritative name
servers and therefore doesn't work in restricted environments.
