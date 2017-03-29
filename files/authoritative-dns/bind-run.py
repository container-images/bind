#!/usr/bin/python

from __future__ import print_function, unicode_literals

import yaml
import mako.template
import subprocess

# Read templates
with open("/files/authoritative-dns/named.conf.mako") as stream:
    conf_template = mako.template.Template(stream.read())
with open("/files/authoritative-dns/zones.mako") as stream:
    zone_template = mako.template.Template(stream.read())

# Read configuration file
with open("/files/authoritative-dns/config.yaml") as stream:
    data = yaml.load(stream)

# Write configuration files
with open("/etc/named.conf", "w") as stream:
    print(conf_template.render(**data), file=stream)
for domain, domain_data in data["domains"].items():
    with open("/etc/named/{}".format(domain), "w") as stream:
        print(zone_template.render(**domain_data), file=stream)

# Run the nameserver
subprocess.check_call(["/usr/sbin/named", "-u", "named", "-g"])
