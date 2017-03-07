#!/bin/bash
kill `cat $XROOTD_LOGDIR/xrootd.pid`
kill `cat $XROOTD_LOGDIR/cmsd.pid`
