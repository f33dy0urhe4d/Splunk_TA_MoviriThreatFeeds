#!/bin/bash
#Script that downloads the iblocklist - RapidShare Black List
#
#==============================================================================
#Fix error when calling script from Splunk
#==============================================================================

unset LD_LIBRARY_PATH

#==============================================================================
#iblocklist - RapidShare Black List
#==============================================================================

logger -t Splunk-iblocklist-rapidshare "iblocklist - RapidShare Black List"

wget http://list.iblocklist.com/?list=zfucwtjkfwkalytktyiw -O /tmp/IP_rapidshare.gz

if [ -s /tmp/IP_rapidshare.gz ]
then
   echo "# Generated: `date`" >  /opt/splunk/etc/apps/moviri-threatfeeds/logs/rapidshare_black_list.txt

   zcat /tmp/IP_rapidshare.gz |grep -v \# | grep -v "^$"| cut -d: -f 2 | awk -F- '{system("/opt/splunk/etc/apps/moviri-threatfeeds/bin/prips -c "$1" "$2)}' | sed 's/$/ iBlocklist Rapidshare/'  >> /opt/splunk/etc/apps/moviri-threatfeeds/logs/rapidshare_black_list.txt
fi

rm /tmp/IP_rapidshare.gz
