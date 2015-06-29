#!/usr/bin/env python3

from __future__ import print_function
import sys
import os
import socket
import threading
from fcgi import *
import http.client
import time

try:
    import SocketServer
except:
    import socketserver
    SocketServer = socketserver

def wait_for_url(url):
    time.sleep(0.2)
    http.client.HTTPConnection(url, 9090, timeout=10)

class ThreadedTCPRequestHandler(SocketServer.BaseRequestHandler):
    def handle(self):
        port = str(self.server.server_address[1])
        data = self.request.recv(8192)

        f = open(port + ".txt", "w")
        f.write(str(data))
        f.close()

        response = bytes("""HTTP/1.1 200 OK
Content-Type: application/xhtml; charset=utf-8
Content-Length: {0}

{1}
""".format(len(port), port), 'UTF-8')

        if str(data).find("REQUEST_METHOD") != -1:
            send_fcgi_response(self.request, data, response)
        else:
            self.request.sendall(response)

class ThreadedTCPServer(SocketServer.ThreadingMixIn, SocketServer.TCPServer):
    pass

def start_server(port):
    SocketServer.TCPServer.allow_reuse_address = True
    handler = ThreadedTCPRequestHandler
    server = ThreadedTCPServer(("localhost", port), handler)
    server_thread = threading.Thread(target=server.serve_forever)
    server_thread.start()
    return server, server_thread

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def cleanup(d):
    ret = os.system("rm -f ./*/*.conf")
    ret = os.system("rm -f ./" + d + "/8080.txt")
    ret = os.system("rm -f ./" + d + "/8081.txt")
    ret = os.system("rm -rf ./" + d + "/certs")
    ret = os.system("rm -rf ./" + d + "/haproxy.output")

def test_generate_cfg(d):
    cmd = 'export `cat {0}`; ../nginx-cfg {1} {2} --debug; diff -u {3}/webconf.result {4}/*.conf'.format(d + "/test.env", d, d, d, d)
    ret = os.system(cmd)
    if ret != 0:
        print(bcolors.FAIL + "*** " + d + ": FAILED" + bcolors.ENDC)
        if len(sys.argv) == 2:
            del sys.argv[1]
            os.system("mv {0}/*.conf {1}/webconf.result ".format(d, d))

    return ret

def test_do_requests(d):
    if not os.path.exists(d + "/requests.sh"):
        return 0

    server_8080, thread_8080 = start_server(8080)
    server_8081, thread_8081 = start_server(8081)

    os.system("killall nginx >/dev/null 2>&1")
    os.system("nginx -c ./nginx.conf -p ./ > ./" + d + "/haproxy.output 2>&1 &")
    wait_for_url("http::/localhost:9090")

    os.chdir(d)
    ret = os.system("/bin/bash ./requests.sh")
    os.chdir("..")
    if ret != 0:
        print(bcolors.FAIL + "*** " + d + ": FAILED" + bcolors.ENDC)
        print("requests.sh returned an error")
    os.system("killall nginx")

    server_8080.shutdown()
    server_8081.shutdown()

    return ret

def runtest(d):
    print(bcolors.OKGREEN + "*** " + d + ": STARTING" + bcolors.ENDC)
    ret = 0

    cleanup(d)
    
    tests = []
    tests.append(test_generate_cfg)
    tests.append(test_do_requests)

    for test in tests:
        ret = test(d)
        if ret != 0:
            break

    if ret == 0:
        print(bcolors.OKGREEN + "*** " + d + ": PASSED" + bcolors.ENDC)
        cleanup(d)
    return ret

tests = os.listdir(".")
tests.sort()
for d in tests:
    if os.path.isdir(d) and len(d) == 3:
        if runtest(d) != 0:
            sys.exit(1)
    