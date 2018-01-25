#!/bin/bash

export P3S_HOME=/afs/cern.ch/user/n/np04dqm/projects/p3s
export DQM_HOME=/afs/cern.ch/user/n/np04dqm/projects/dqmconfig

source $P3S_HOME/configuration/lxvm.sh > /dev/null

source /afs/cern.ch/user/n/np04dqm/vp3s/bin/activate

to=`$P3S_HOME/clients/TO.py -t $P3S_PILOT_TO -d`


if [[ $to != "" ]];
then
echo $to
fi
