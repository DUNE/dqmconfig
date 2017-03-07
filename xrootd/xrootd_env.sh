# This script needs to be edited (paths changed)
# to be applicable to a general use scenario
#
export HOSTNAME=`hostname`
#
export XROOTD_BASE=/opt/xrootd
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$XROOTD_BASE/lib
export PATH=$PATH:$XROOTD_BASE/bin
#
export XROOTD_EXPORT=/home/maxim/p3sdata/
export XROOTD_AUTH_FILE=/home/maxim/auth_file/
export XROOTD_XRDR=sagacity.local
#
# Can only pick one of the two, the first
# set variable takes precedence
# Option 1: named pipe (FIFO)
export XROOTD_NOTIFY_FIFO=/home/maxim/$HOSTNAME.txt
# Option 2: a program to read from stdin
export XROOTD_NOTIFY_RECEIVER=/home/maxim/$HOSTNAME.sh
