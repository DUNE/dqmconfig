#!/bin/sh

# Monitor the size of the p3s inbox

export P3S_HOME=/afs/cern.ch/user/n/np04dqm/public/p3s/p3s
export DQM_HOME=/afs/cern.ch/user/n/np04dqm/public/p3s/dqmconfig

source $P3S_HOME/configuration/lxvm_np04dqm.sh > /dev/null

# echo Activating venv at lxvm
source $P3S_VENV/bin/activate

export P3S_INPUT_DIR=$P3S_DIRPATH/input

if [ ! -d "$P3S_INPUT_DIR" ]; then
    $P3S_HOME/clients/service.py -n inputsize -m "Problem with directory $P3S_INPUT_DIR"
    exit 1
fi

cd $INPUT_DIR
f=`du -sh .| awk '{print $1}'`
$P3S_HOME/clients/service.py -n inputsize -m $f

exit 0
