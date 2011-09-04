#!/bin/bash
#set -xv

# Usage: msmb SVRNAME NETWORK
# @look: http://debianforum.de/forum/viewtopic.php?f=30&p=756170

# small parameter check
if [ $# -ne 1 ] && [ $# -ne 2 ]
then
    echo "Parameter error!"
    exit 1
fi
#echo ok

# set the network-variable so I wont get the last-entry which maybe has the lowest bandwich
network=`echo $2`
#echo Network: $network

if [ $# =  1 ]
then
    network=`echo '.'`
fi

# find ip-address
tmp=`nmblookup $1 | grep $network | sed -n '$p'`
echo $tmp | grep "name_query failed"

# check if failed to resolve by grep-result
if [ $? -ne 1 ]
then
    echo "Could not resolve servername!"
    exit 1
fi

# now get ip-address
ipa=`echo $tmp | sed -n 's/ .*//;$p'`
echo $ipa
