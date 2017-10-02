#!/bin/bash

export P3S_HOME=/afs/cern.ch/user/m/mxp/projects/p3s
export DQM_HOME=/afs/cern.ch/user/m/mxp/projects/dqmconfig

source $P3S_HOME/configuration/lxvm.sh

export outdir=$P3S_DIRPATH/output

usedDisk=`du -sh $outdir`
echo Used space before cleaning: $usedDisk

#cd $outdir

#curdir=`pwd`

echo Working in $curdir

#if [[ $curdir == /afs* ]]
#then
#    echo GOT INTO AFS, EXITING
#    exit
#fi
    



N=`find $outdir -maxdepth 1 -mindepth 1 -mmin +1200 -exec ls -ld  {} \; | wc -l`
echo $N directories found exceeding the data lifetime of $DQM_DATA_LIFE minutes

find . -maxdepth 1 -mindepth 1 -mmin +$DQM_DATA_LIFE -exec rm -fr  {} \;

usedDisk=`du -sh $outdir`
echo Used space after cleaning: $usedDisk
