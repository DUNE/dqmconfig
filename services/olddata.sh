#!/bin/bash


export P3S_HOME=/afs/cern.ch/user/n/np04dqm/public/p3s/p3s
export DQM_HOME=/afs/cern.ch/user/n/np04dqm/public/p3s/dqmconfig

source $P3S_HOME/configuration/lxvm.sh > /dev/null

source /afs/cern.ch/user/n/np04dqm/public/vp3s/bin/activate

export targetDir=$P3S_DIRPATH/$1

if [ ! -d "$targetDir" ]; then
    $P3S_HOME/clients/service.py -n tscan -m "Problem with directory $targetDir"
    exit 1
fi



usedDisk1=`du -sh $targetDir`
# echo Used space before cleaning: $usedDisk1

cd $targetDir

curdir=`pwd`

# echo Working: $curdir

if [[ $curdir == /afs* ]]
then
    echo GOT INTO AFS, EXITING
    exit
fi



N=`find $targetDir -maxdepth 1 -mindepth 1 -mmin +$DQM_DATA_LIFE -exec ls -ld  {} \; | wc -l`

find $targetDir -maxdepth 1 -mindepth 1 -mmin +$DQM_DATA_LIFE -exec rm -fr  {} \;

usedDisk2=`du -sh $targetDir`

message="$N directories found exceeding the data lifetime of $DQM_DATA_LIFE minutes. Used space bedore/after cleaning: $usedDisk1/$usedDisk2"

$P3S_HOME/clients/service.py -n olddata -m "$message"
