#!/bin/bash
#Script that downloads the iblocklist - LogMeIn Black List
#
#==============================================================================
#Fix error when calling script from Splunk
#==============================================================================

unset LD_LIBRARY_PATH

#==============================================================================
#iblocklist - LogMeIn Black List
#==============================================================================

logger -t Splunk-iblocklist-logmein "iblocklist - LogMeIn Black List"

wget http://list.iblocklist.com/?list=logmein -O /tmp/IP_logmein.gz

if [ -s /tmp/IP_logmein.gz ]
then
   echo "# Generated: `date`" >  /opt/splunk/etc/apps/moviri-threatfeeds/logs/logmein_black_list.txt

   zcat /tmp/IP_logmein.gz |grep -v \# | grep -v "^$"| cut -d: -f 2 | awk -F- '{system("/opt/splunk/etc/apps/moviri-threatfeeds/bin/prips -c "$1" "$2)}' | sed 's/$/ iBlocklist LogMeIn/'  >> /opt/splunk/etc/apps/moviri-threatfeeds/logs/logmein_black_list.txt
fi

rm /tmp/IP_logmein.gz
