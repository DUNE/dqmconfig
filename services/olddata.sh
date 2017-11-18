#!/bin/bash

export P3S_HOME=/afs/cern.ch/user/m/mxp/projects/p3s
export DQM_HOME=/afs/cern.ch/user/m/mxp/projects/dqmconfig

source $P3S_HOME/configuration/lxvm.sh > /dev/null

export outdir=$P3S_DIRPATH/output

usedDisk=`du -sh $outdir`
echo Used space before cleaning: $usedDisk

cd $outdir

curdir=`pwd`

echo Working: $curdir

if [[ $curdir == /afs* ]]
then
    echo GOT INTO AFS, EXITING
    exit
fi
    



N=`find $outdir -maxdepth 1 -mindepth 1 -mmin +$DQM_DATA_LIFE -exec ls -ld  {} \; | wc -l`

find $outdir -maxdepth 1 -mindepth 1 -mmin +$DQM_DATA_LIFE -exec rm -fr  {} \;

usedDisk=`du -sh $outdir`

message="$N directories found exceeding the data lifetime of $DQM_DATA_LIFE minutes. Used space after cleaning: $usedDisk"

$P3S_HOME/clients/service.py -n OldData -m '$message'
