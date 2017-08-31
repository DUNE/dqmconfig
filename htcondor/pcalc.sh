#!/bin/bash

export P3S_HOME=/afs/cern.ch/user/m/mxp/projects/p3s
export DQM_HOME=/afs/cern.ch/user/m/mxp/projects/dqmconfig

source $P3S_HOME/configuration/p3s_lx_setup.sh

if [ -z ${P3S_PILOTS+x} ];
then exit;
fi

source /afs/cern.ch/user/m/mxp/vp3s/bin/activate

p=`$P3S_HOME/clients/summary.py -p`

if [[ $p < $P3S_PILOTS ]];
then
    echo required pilots:$P3S_PILOTS, detected:$p ;
    toSub=$(( P3S_PILOTS-p ));
    echo $toSub
    condor_submit N=$toSub $DQM_HOME/htcondor/psub.jdl
fi
