% dns-bind(1)
% Rado Pitonak \<rpitonak@redhat.com\>
% DATE 19.04.2017

# NAME
dns-bind - Domain name system resolver and server.

# DESCRIPTION
Bind enables you to publish your DNS information on the Internet, and to resolve DNS queries for your users. This image is based on Fedora.

## USAGE

To pull the dns-bind container run:

      # docker pull modularitycontainers/dns-bind

To run your DNS server in docker container:

      # docker run -d -p 127.0.0.1:53:53 -p 127.0.0.1:53:53/udp -e SERVER_TYPE=<TYPE> modularitycontainers/dns-bind

Substitute <TYPE> with either `AUTHORITATIVE` or `CACHING` option. If option value is not provided default value is `CACHING`.

## ENVIROMENT VARIABLES

SERVER_TYPE
    Type of DNS server.
    DEFAULT: CACHING

## SECURITY IMPLICATIONS

-d

     Runs continuously as a daemon process in the background

-p 127.0.0.1:53:53

     Opens  container  port  53  and  maps it to the same port on the Host.     
