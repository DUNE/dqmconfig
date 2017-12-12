#!/bin/bash

export P3S_HOME=/afs/cern.ch/user/m/mxp/projects/p3s
export DQM_HOME=/afs/cern.ch/user/m/mxp/projects/dqmconfig

source $P3S_HOME/configuration/lxvm.sh > /dev/null


# echo Activating venv at lxvm
source /afs/cern.ch/user/m/mxp/vp3s/bin/activate
export P3S_HOME=/afs/cern.ch/user/m/mxp/projects/p3s
export outdir=$P3S_DIRPATH/output

if [ ! -d "$outdir" ]; then
    $P3S_HOME/clients/service.py -n tscan -m "Problem with directory $outdir"
    exit 1
fi



usedDisk1=`du -sh $outdir`
# echo Used space before cleaning: $usedDisk1

cd $outdir

curdir=`pwd`

# echo Working: $curdir

if [[ $curdir == /afs* ]]
then
    echo GOT INTO AFS, EXITING
    exit
fi
    



N=`find $outdir -maxdepth 1 -mindepth 1 -mmin +$DQM_DATA_LIFE -exec ls -ld  {} \; | wc -l`

find $outdir -maxdepth 1 -mindepth 1 -mmin +$DQM_DATA_LIFE -exec rm -fr  {} \;

usedDisk2=`du -sh $outdir`

message="$N directories found exceeding the data lifetime of $DQM_DATA_LIFE minutes. Used space bedore/after cleaning: $usedDisk1/$usedDisk2"

$P3S_HOME/clients/service.py -n olddata -m "$message"
