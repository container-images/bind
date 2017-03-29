#!/usr/bin/python

from __future__ import print_function, unicode_literals

import sys
import yaml
import mako.template
import subprocess

# Read template
with open("/files/caching-dns/named.conf.mako") as stream:
    template = mako.template.Template(stream.read())

# Read configuration file
with open("/files/caching-dns/config.yaml") as stream:
    data = yaml.load(stream)

# Fallback to /etc/resolv.conf contents
if not data.get("nameservers"):
    if "nameservers" in data:
	del data["nameservers"]
    with open("/etc/resolv.conf") as stream:
	for line in stream:
	    line = line.strip()
	    if line.startswith("nameserver "):
		data.setdefault("nameservers", []).append(line.split()[1])

# Write configuration file
with open("/etc/named.conf", "w") as stream:
    print(template.render(**data), file=stream)

# Run the nameserver
subprocess.check_call(["/usr/sbin/named", "-u", "named", "-g"])
