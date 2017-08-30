#!/bin/bash

if [ -z ${P3S_PILOTS+x} ];
then exit;
fi

p=`echo 10`
if [[ $p < $P3S_PILOTS ]];
then
    echo required pilots:$P3S_PILOTS, detected:$p ;
    toSub=$(( P3S_PILOTS-p ));
    echo $toSub
    condor_submit N=$toSub /afs/cern.ch/user/m/mxp/projects/dqmconfig/htcondor/psub.jdl
fi
