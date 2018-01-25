#!/bin/bash

export P3S_HOME=/afs/cern.ch/user/n/np04dqm/projects/p3s
export DQM_HOME=/afs/cern.ch/user/n/np04dqm/projects/dqmconfig

source $P3S_HOME/configuration/lxvm_np04dqm.sh > /dev/null

source /afs/cern.ch/user/n/np04dqm/public/vp3s/bin/activate


purge=`$P3S_HOME/clients/purge.py -w pilot -s timeout -d`
