#!/bin/bash
#Script that downloads the iblocklist - ThePirateBay Black List
#
#==============================================================================
#Fix error when calling script from Splunk
#==============================================================================

unset LD_LIBRARY_PATH

#==============================================================================
#iblocklist - ThePirateBay Black List
#==============================================================================

logger -t Splunk-iblocklist-tpb "iblocklist - ThePirateBay Black List"

wget http://list.iblocklist.com/?list=nzldzlpkgrcncdomnttb -O /tmp/IP_tpb.gz

if [ -s /tmp/IP_tpb.gz ]
then
   echo "# Generated: `date`" >  /opt/splunk/etc/apps/moviri-threatfeeds/logs/tpb_black_list.txt

   zcat /tmp/IP_tpb.gz |grep -v \# | grep -v "^$"| cut -d: -f 2 | awk -F- '{system("/opt/splunk/etc/apps/moviri-threatfeeds/bin/prips -c "$1" "$2)}' | sed 's/$/ iBlocklist ThePirateBay/'  >> /opt/splunk/etc/apps/moviri-threatfeeds/logs/tpb_black_list.txt
fi

rm /tmp/IP_tpb.gz
