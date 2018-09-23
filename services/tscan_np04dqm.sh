#!/bin/sh

# Maxim's note - let's mute the output for now as the short
# cron cycle leads to flooding of my mailbox

export P3S_HOME=/afs/cern.ch/user/n/np04dqm/public/p3s/p3s
export DQM_HOME=/afs/cern.ch/user/n/np04dqm/public/p3s/dqmconfig

source $P3S_HOME/configuration/lxvm_np04dqm.sh > /dev/null


Nargs=$#


if [ $Nargs -lt 5 ]; then
    echo Wrong number of arguments - expecting at least 3 - exiting...
    echo Expecting:
    echo \* time window \(minutes\) to trigger on a modified file, needs to be negative for "newer than" and positive for "older than"
    echo \* min size \(e.g. +7G\)
    echo \* wildcard or part of it e.g. np04
    echo \* max number of job groups to be created within a single invocation
    echo \* Debug option
    exit
fi

# echo Activating venv at lxvm
source $P3S_VENV/bin/activate

export P3S_INPUT_DIR=$P3S_DIRPATH/input

if [ ! -d "$P3S_INPUT_DIR" ]; then
    $P3S_HOME/clients/service.py -n tscan -m "Problem with directory $P3S_INPUT_DIR"
    exit 1
fi

cd $P3S_INPUT_DIR
d=`pwd`

files=`find . -maxdepth 1 -mindepth 1 -mmin $1 -size $2 -name "$3*.root" | sed 's/\.\///'`

verb=0
if [ ! -z "$4" ] && [ "$4" == 'D' ]; then
    echo Directory: $d
    echo Files:$files
    verb=2
fi

# $P3S_HOME/clients/service.py -n tscan -m "$files"

# echo ${#files[@]}

COUNTER=0

for f in $files
do
if [ ! -z "$5" ] && [ "$5" == 'D' ]; then
    echo '->' $f
fi

if [ ! -z "$5" ] && [ "$5" == 'T' ]; then
    echo '->' $f
fi

if [ ! -z "$5" ] && [ "$5" != 'T' ]; then
    $P3S_HOME/clients/dataset.py -v $verb -g -i $d -f $f -J $P3S_HOME/inputs/larsoft/monitor/hitmonitor_data_main.json
    $P3S_HOME/clients/dataset.py -v $verb -g -A -i $d -f $f -J $P3S_HOME/inputs/larsoft/evdisp/eventdisplay_data.json
    $P3S_HOME/clients/dataset.py -v $verb -g -A -i $d -f $f -J $P3S_HOME/inputs/larsoft/femb/fembcount_data.json
fi
let COUNTER=COUNTER+1
if [ "$COUNTER" -eq "$4" ]; then
    break
fi

done

exit
