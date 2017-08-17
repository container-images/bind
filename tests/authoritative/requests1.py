#!/usr/bin/python
# -*- coding: utf-8 -*-
#
# This Modularity Testing Framework helps you to write tests for modules
# Copyright (C) 2017 Red Hat, Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# he Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# Authors: Rado Pitonak <rpitonak@redhat.com>
#

from avocado import main
from avocado.core import exceptions
from moduleframework import module_framework
import time


class RequestsCheck(module_framework.AvocadoTest):
    """
    :avocado: enable
    """

    def testRequestPassed(self):
        """
        Try request to nameserver which is in DNS server config
        """
        self.start()

        time.sleep(5)

        self.run("dig @127.0.0.1 example.net | grep \"AUTHORITY SECTION:\"")

    def testRequestFailed(self):
        """
        Try request to nameserver which is NOT in DNS server config
        """
        self.start()

        time.sleep(5)

        result = self.run("dig @127.0.0.1 examplee.nt | grep \"AUTHORITY SECTION:\"", ignore_status=True)
        self.assertEqual(1, result.exit_status)


if __name__ == '__main__':
    main()
