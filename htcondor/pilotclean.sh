#!/bin/bash

export P3S_HOME=/afs/cern.ch/user/m/mxp/projects/p3s
export DQM_HOME=/afs/cern.ch/user/m/mxp/projects/dqmconfig

source $P3S_HOME/configuration/lxvm.sh > /dev/null

source /afs/cern.ch/user/m/mxp/vp3s/bin/activate

to=`$P3S_HOME/clients/TO.py -t $P3S_PILOT_TO`


if [[ $to != "" ]];
then
echo timeout:$to
fi

#echo $to
#purge=`$P3S_HOME/clients/purge.py -w pilot -s timeout`
#echo purge:$purge
