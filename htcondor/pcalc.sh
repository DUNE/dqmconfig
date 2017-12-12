#!/bin/bash

idle=`/usr/bin/condor_q | tail -1 | cut -d' ' -f 7`

re='^[0-9]+$'
if ! [[ $idle =~ $re ]] ; then
    echo "error: Not a number" >&2
    echo $idle
    exit 1
fi

if (( $idle > 0 ));
then
    echo $idle idling condor jobs found, exiting
    exit
fi

export P3S_HOME=/afs/cern.ch/user/m/mxp/projects/p3s
export DQM_HOME=/afs/cern.ch/user/m/mxp/projects/dqmconfig

source $P3S_HOME/configuration/lxvm.sh > /dev/null

if [ -z ${P3S_PILOTS+x} ];
then
    echo P3S_PILOTS undefined, exiting
    exit
fi

source /afs/cern.ch/user/m/mxp/vp3s/bin/activate

p=`$P3S_HOME/clients/summary.py -p`

if (( $p < $P3S_PILOTS ));
then
    toSub=$(( P3S_PILOTS-p ));
    msg="Required pilots:$P3S_PILOTS, detected:$p, sumbitting $toSub"
    $P3S_HOME/clients/service.py -m $msg -n pcalc
    condor_submit N=$toSub CONDORLOG=$P3S_CONDOR_LOG CONDOROUTPUT=$P3S_CONDOR_OUTPUT CONDORERROR=$P3S_CONDOR_ERROR MAXRUNTIME=$P3S_PILOT_MAXRUNTIME $DQM_HOME/htcondor/psub.jdl > /dev/null
fi
