#!/bin/bash

idle=`/usr/bin/condor_q | tail -1 | cut -d' ' -f 7`

if [[ $idle > 0 ]];
then
    echo $idle idling condor jobs found, exiting
    exit
fi

export P3S_HOME=/afs/cern.ch/user/m/mxp/projects/p3s
export DQM_HOME=/afs/cern.ch/user/m/mxp/projects/dqmconfig

source $P3S_HOME/configuration/lxvm.sh

if [ -z ${P3S_PILOTS+x} ];
then
    echo P3S_PILOTS undefined, exiting
    exit
fi

source /afs/cern.ch/user/m/mxp/vp3s/bin/activate

to=`$P3S_HOME/clients/TO.py`
echo timeout:$to

p=`$P3S_HOME/clients/summary.py -p`

echo required pilots:$P3S_PILOTS, detected:$p ;

#if (( $p < $P3S_PILOTS ));
#then
#    echo !
#fi

if (( $p < $P3S_PILOTS ));
then
    toSub=$(( P3S_PILOTS-p ));
    echo $toSub
    condor_submit N=$toSub $DQM_HOME/htcondor/psub.jdl
fi
