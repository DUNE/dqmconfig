#!/bin/bash
cmsd    -b -l $XROOTD_LOGDIR/cmsd.log      -s $XROOTD_LOGDIR/cmsd.pid     -c $XROOTD_CFG_FILE
xrootd  -b -l $XROOTD_LOGDIR/xrootd.log    -s $XROOTD_LOGDIR/xrootd.pid   -c $XROOTD_CFG_FILE
