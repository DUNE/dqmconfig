# This script needs to be edited (paths changed)
# to be applicable to a general use scenario
#
# It needs to be sourced before running other shell
# scripts in this directory
#
export HOSTNAME=`hostname`
export XROOTD_USER=`whoami`

export XROOTD_BASE=/opt/xrootd
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$XROOTD_BASE/lib
export PATH=$PATH:$XROOTD_BASE/bin

export XROOTD_EXPORT=/home/maxim/p3sdata/
export XROOTD_AUTH_FILE=/home/maxim/auth_file/
export XROOTD_CFG_FILE=/home/maxim/projects/dqmconfig/xrootd/x.cfg

export XROOTD_XRDR=sagacity.local
export XROOTD_LOGDIR=/tmp/$XROOTD_USER/p3s/xrootd/

# ----------------------------------------------
# Can only pick one of the two, the first
# set variable takes precedence
# Option 1: named pipe (FIFO)
export XROOTD_NOTIFY_FIFO=/home/maxim/$HOSTNAME.txt
# Option 2: a program to read from stdin
export XROOTD_NOTIFY_RECEIVER=/home/maxim/$HOSTNAME.sh
