#!/bin/bash
xrootd  -b -l $XROOTD_LOGDIR/xrootd.log    -s $XROOTD_LOGDIR/xrootd.pid   -c $XROOTD_CFG_FILE
cmsd    -b -l $XROOTD_LOGDIR/cmsd.log      -s $XROOTD_LOGDIR/cmsd.pid     -c $XROOTD_CFG_FILE
