#!/usr/bin/env python3
from __future__ import print_function

import time
import random

import util

pub = util.PubClient(master='192.168.1.122', topic='processing')

def doit():
    sub = util.SubClient('localhost', u'dreamscape2')
    while True:
        r = sub.recv()
        # r is of the form ('button', 1)
        print('recv', r, type(r[1]))

        if r[0] == u'giraffe_side' or r[0] == u'igloo_side':
		pub.send(r[0], int(r[1]))

        #if r[0] == u'giraffe_side':
        #    pub.send('whitewash', int(r[1]))

        #if r[0] == u'giraffe_side' and int(r[1]) == 1:
        #    print('send!')
        #    pub.send('giraffe_side', 1)

        #elif r[0] == u'igloo_side' and int(r[1]) == 1:
        #    print('send!')
        #    pub.send('igloo_side', 1)

if __name__ == '__main__':
    doit()

