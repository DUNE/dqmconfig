#!/bin/bash

idle=`/usr/bin/condor_q | tail -1 | cut -d' ' -f 7`

if (( $idle > 0 ));
then
    echo $idle idling condor jobs found, exiting
    exit
fi

export P3S_HOME=/afs/cern.ch/user/m/mxp/projects/p3s
export DQM_HOME=/afs/cern.ch/user/m/mxp/projects/dqmconfig

source $P3S_HOME/configuration/lxvm.sh

outdir = $P3S_DIRPATH/output

du = `du -sh $outdir`
echo Used space: $du

cd $outdir
N=`find . -maxdepth 1 -mindepth 1 -mmin +1200 -exec ls -ld  {} \; | wc -l`
echo $N directories found exceeding the data lifetime of $DQM_DATA_LIFE minutes

find . -maxdepth 1 -mindepth 1 -mmin +$DQM_DATA_LIFE -exec rm -fr  {} \;
