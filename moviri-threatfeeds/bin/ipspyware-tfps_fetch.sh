#!/bin/bash
#Script that downloads the iblocklist - BT Spyware Black List
#
#==============================================================================
#Fix error when calling script from Splunk
#==============================================================================

unset LD_LIBRARY_PATH

#==============================================================================
#iblocklist - BT Spyware Black List
#==============================================================================

logger -t Splunk-iblocklist-spyware "iblocklist - BT Spyware Black List"

wget http://list.iblocklist.com/?list=bt_spyware -O /tmp/IP_spyware.gz

if [ -s /tmp/IP_spyware.gz ]
then
   echo "# Generated: `date`" >  /opt/splunk/etc/apps/moviri-threatfeeds/logs/spyware_black_list.txt

   zcat /tmp/IP_spyware.gz |grep -v \# | grep -v "^$"| cut -d: -f 2 | awk -F- '{system("/opt/splunk/etc/apps/moviri-threatfeeds/bin/prips -c "$1" "$2)}' | sed 's/$/ iBlocklist BT Spyware/'  >> /opt/splunk/etc/apps/moviri-threatfeeds/logs/spyware_black_list.txt
fi

rm /tmp/IP_spyware.gz
