#!/bin/bash

export P3S_HOME=/afs/cern.ch/user/n/np04dqm/public/p3s/p3s
export DQM_HOME=/afs/cern.ch/user/n/np04dqm/public/p3s/dqmconfig

source $P3S_HOME/configuration/lxvm_np04dqm.sh > /dev/null

source /afs/cern.ch/user/n/np04dqm/public/vp3s/bin/activate

to=`$P3S_HOME/clients/TO.py -t $P3S_PILOT_TO -d`
jto=`$P3S_HOME/clients/TO.py -w job -t 0 -d`


if [[ $to != "" ]];
then
echo to $to
fi

if [[ $jto != "" ]];
then
echo jto $jto
fi
