#!/bin/bash

# BIND includes a utility called rndc which allows command line administration of the named daemon from the localhost or a remote host.
# In order to prevent unauthorized access to the named daemon, BIND uses a shared secret key authentication method to grant privileges to hosts.

/usr/libexec/generate-rndc-key.sh
