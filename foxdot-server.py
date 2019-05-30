#!/usr/bin/env python
from __future__ import print_function
import argparse
import socket
from contextlib import closing
from threading import Thread, Lock

from FoxDot import * 

DEFAULT_PORT = 7088

_env = None
lock = Lock()

def main():
    """ Run a FoxDot process and listen for input on a socket """
    global _env
    parser = argparse.ArgumentParser(description=main.__doc__)
    parser.add_argument('-l', action='append', nargs='*',
                        help="library to load")
    parser.add_argument('-p', type=int, default=DEFAULT_PORT,
                        help="port (default %(default)s)")
    args = parser.parse_args()

    serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    serversocket.bind(('localhost', args.p))
    serversocket.listen(0)

    # This should be enabled to see foxdot messages and use those for visualization
#    my_client = OSCClient()
#    my_client.connect( ("localhost", DEFAULT_VISUALIZATION_PORT) )
#    Server.forward = my_client

    _env = FoxDotCode()
    if args.l:
        for arg in args.l:
            for fname in arg:
                with open(fname, 'r') as ifile:
                    execute(ifile.read(), verbose=False)
    print("Listening on port %d" % args.p)

    while True:
        connection, address = serversocket.accept()
        handler = Thread(target=handle_connection, args=(connection,))
        handler.start()

def execute(code, verbose=True):
    with lock:
        return _env(code, verbose=verbose)


def handle_connection(connection):
    with closing(connection):
        chunks = []
        while True:
            buf = connection.recv(4096)
            if not buf:
                break
            chunks.append(buf)
        if chunks:
            merged = str(b''.join(chunks), "utf-8")
            ret = execute(merged)
            # connection.send(ret.encode())

if __name__ == '__main__':
    main()
