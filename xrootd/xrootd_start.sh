#!/bin/bash
cmsd    -b -l /home/maxim/cmsd.log      -s cmsd.pid     -c client.cfg
xrootd  -b -l /home/maxim/xrootd.log    -s xrootd.pid   -c client.cfg
