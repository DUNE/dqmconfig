#!/bin/bash
cmsd    -b -l $XROOTD_LOGDIR/cmsd.log      -s $XROOTD_LOGDIR/cmsd.pid     -c x.cfg
xrootd  -b -l $XROOTD_LOGDIR/xrootd.log    -s $XROOTD_LOGDIR/xrootd.pid   -c x.cfg
