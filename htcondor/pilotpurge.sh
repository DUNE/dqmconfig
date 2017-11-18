#!/bin/bash

export P3S_HOME=/afs/cern.ch/user/m/mxp/projects/p3s
export DQM_HOME=/afs/cern.ch/user/m/mxp/projects/dqmconfig

source $P3S_HOME/configuration/lxvm.sh > /dev/null

source /afs/cern.ch/user/m/mxp/vp3s/bin/activate


purge=`$P3S_HOME/clients/purge.py -w pilot -s timeout`
echo purge:$purge
