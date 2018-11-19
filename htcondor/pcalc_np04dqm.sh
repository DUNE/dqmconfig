#!/bin/bash

# basic way to match to numeric
re='^[0-9]+$'

export P3S_HOME=/afs/cern.ch/user/n/np04dqm/public/p3s/p3s
export DQM_HOME=/afs/cern.ch/user/n/np04dqm/public/p3s/dqmconfig

source $P3S_HOME/configuration/lxvm_np04dqm.sh > /dev/null
source /afs/cern.ch/user/n/np04dqm/public/vp3s/bin/activate

idle=`/usr/bin/condor_q 2>&1| tail -1 | cut -d' ' -f 7`

if ! [[ $idle =~ $re ]] ; then
    # echo "error: Not a number" >&2
    mess=`echo $idle`
    $P3S_HOME/clients/service.py -m "error: $mess" -n pcalc
    # echo $idle
    exit 1
fi

if (( $idle > 0 ));
then
    $P3S_HOME/clients/service.py -m "$idle idling condor jobs found, exiting" -n pcalc
    exit
fi

export P3S_PILOTS=`$P3S_HOME/clients/siteinfo.py -s lxvm -w pilots`

if [ -z ${P3S_PILOTS+x} ];
then
    $P3S_HOME/clients/service.py -m "$P3S_PILOTS undefined, exiting" -n pcalc
    exit
fi

p=`$P3S_HOME/clients/summary.py -p`

if (( $p < $P3S_PILOTS ));
then
    toSub=$(( P3S_PILOTS-p ));
    msg="Required pilots:$P3S_PILOTS, detected:$p, submit $toSub"
    $P3S_HOME/clients/service.py -m "$msg" -n pcalc
    # to redirect condor add this before the JDL file: -remote bigbird13.cern.ch
    condor_submit N=$toSub CONDORLOG=$P3S_CONDOR_LOG CONDOROUTPUT=$P3S_CONDOR_OUTPUT CONDORERROR=$P3S_CONDOR_ERROR MAXRUNTIME=$P3S_PILOT_MAXRUNTIME $DQM_HOME/htcondor/psub_np04dqm.jdl > /dev/null
fi
