#!/bin/bash
#Script that downloads the iblocklist - Tor Black List
#
#==============================================================================
#Fix error when calling script from Splunk
#==============================================================================

unset LD_LIBRARY_PATH

#==============================================================================
#iblocklist - Tor Black List
#==============================================================================

logger -t Splunk-Iblocklist-Tor "iblocklist - Tor Black List"

wget http://list.iblocklist.com/?list=tor -O /tmp/IP_tor.gz

if [ -s /tmp/IP_tor.gz ]
then
   echo "# Generated: `date`" >  /opt/splunk/etc/apps/moviri-threatfeeds/logs/tor_black_list.txt

   zcat /tmp/IP_tor.gz |grep -v \# | grep -v "^$"| cut -d: -f 2 | awk -F- '{system("/opt/splunk/etc/apps/moviri-threatfeeds/bin/prips -c "$1" "$2)}' | sed 's/$/ iBlocklist Tor/'  >> /opt/splunk/etc/apps/moviri-threatfeeds/logs/tor_black_list.txt
fi

rm /tmp/IP_tor.gz
