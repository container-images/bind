# DNS server

An example of [bind DNS server](https://www.isc.org/downloads/bind/) running in docker container based on **fedora 25**.

## Configuration

There are two options for running DNS server:
 - Authoritative
    - you need set domains in [config.yaml](./files/authoritative-dns/config.yaml)
 - Caching (recursive)
    - you can set nameservers in [config.yaml](./files/caching-dns/config.yaml)

## Running in docker

### 1) Shell
```
docker run -d -p 127.0.0.1:53:53 -p 127.0.0.1:53:53/udp -e SERVER_TYPE=<TYPE> rpitonak/dns-bind
```
Substitute \<TYPE\> with either 'AUTHORITATIVE' or 'CACHING' option. If SERVER_TYPE is not set default value is 'CACHING'.
### 2) Makefile
```
$ make
```
This will build, tag and run container. You can change tag by editing this line
```
IMAGE_NAME = dns-bind
```
**Important** variable you can change is type of dns server.
```
TYPE='CACHING'
```
```
TYPE='AUTHORITATIVE'
```
Options of running container can be set like this
```
IMAGE_OPTIONS = \
    -p 127.0.0.1:53:53 \
    -p 127.0.0.1:53:53/udp \
	  -e SERVER_TYPE=$(TYPE)
```

## Deployment notes

At the time of writing this note, docker doesn't work well with firewalld.
Some of the commands below may seem redundant but this is what works for me
at the moment.

    systemctl mask firewalld
    systemctl stop firewalld
    iptables -F
    systemctl restart docker

Also note that the current version of the image talks to authoritative name
servers and therefore doesn't work in restricted environments.
