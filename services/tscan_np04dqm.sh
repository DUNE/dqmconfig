#!/bin/sh

# Maxim's note - let's mute the output for now as the short
# cron cycle leads to flooding of my mailbox

export P3S_HOME=/afs/cern.ch/user/n/np04dqm/public/p3s/p3s
export DQM_HOME=/afs/cern.ch/user/n/np04dqm/public/p3s/dqmconfig

source $P3S_HOME/configuration/lxvm_np04dqm.sh > /dev/null


Nargs=$#


if [ $Nargs -lt 4 ]; then
    echo Wrong number of arguments - expecting at least 3 - exiting...
    echo Expecting:
    echo \* time window \(minutes\) to trigger on a modified file, needs to be negative for "newer than" and positive for "older than"
    echo \* wildcard or part of it e.g. Proto
    echo \* path to the JSON description of the job to be created
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

files=`find . -maxdepth 1 -mindepth 1 -mmin $1 -size +1 -name "$2*.root" | sed 's/\.\///'`

if [ ! -z "$4" ] && [ "$4" == 'D' ]; then
    echo Directory: $d
    echo Files:$files
fi

# $P3S_HOME/clients/service.py -n tscan -m "$files"

# echo ${#files[@]}

for f in $files
do
if [ ! -z "$4" ] && [ "$4" == 'D' ]; then
    echo '->' $f
fi
$P3S_HOME/clients/dataset.py -v 0 -g -i $d -f $f -J $3 $5

# J was: $P3S_HOME/inputs/larsoft/evdisp/evdisp_main.json
done

exit

# env | grep P3
