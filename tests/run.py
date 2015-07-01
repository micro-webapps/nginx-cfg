#!/usr/bin/env python3

from __future__ import print_function
import sys
import os

from webconftests import runtests

class TestImplementation:
    def pre_start(self):
        os.chdir("webconftests")
        os.system("cp ../nginx.conf .")
        os.system("cp ../fastcgi_params .")

    def stop(self):
        os.system("rm -rf __pycache__")
        os.system("rm -rf nginx.conf")
        os.system("rm -rf fastcgi_params")

    def generate_cfg(self, d):
        cmd = 'export `cat {0}`; ../../nginx-cfg {1} {2} --debug; diff -u ../results/{3}/webconf.result {4}/*.conf'.format(d + "/test.env", d, d, d, d)
        return os.system(cmd)

    def start_server(self, d):
        os.system("killall nginx >/dev/null 2>&1")
        os.system("nginx -c ./nginx.conf -p ./ > ./" + d + "/haproxy.output 2>&1 &")
        os.system("sed -i 's|\"\\./|\"" + os.getcwd() + "/apache-test/t/|g' " + d + "/*.conf")

    def stop_server(self, d):
        os.system("killall nginx >/dev/null 2>&1")

impl = TestImplementation()
runtests(impl)
