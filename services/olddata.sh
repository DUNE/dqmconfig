#!/bin/bash

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
