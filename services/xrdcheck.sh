#!/bin/sh

export FILE=np04_raw_run000973_1_dl2.root

export P3S_HOME=/afs/cern.ch/user/n/np04dqm/public/p3s/p3s
export DQM_HOME=/afs/cern.ch/user/n/np04dqm/public/p3s/dqmconfig

source $P3S_HOME/configuration/lxvm_np04dqm.sh > /dev/null



# echo Activating venv at lxvm
source $P3S_VENV/bin/activate

export P3S_TESTINPUT_DIR=$P3S_DIRPATH/testinput

if [ ! -d "$P3S_TESTINPUT_DIR" ]; then
    $P3S_HOME/clients/service.py -n xrdcheck -m "Problem with directory $P3S_TESTINPUT_DIR"
    exit 1
fi

cd $P3S_TESTINPUT_DIR
rm foo xrdcheck.log xrdcheck.error > /dev/null 2>&1
time (xrdcp --silent --tpc first np04_raw_run000973_1_dl2.root foo) >xrdcheck.log 2>xrdcheck.error
f=`grep real  xrdcheck.error | awk '{print $2}'`
$P3S_HOME/clients/service.py -n xrdcheck -m $f

exit 0
