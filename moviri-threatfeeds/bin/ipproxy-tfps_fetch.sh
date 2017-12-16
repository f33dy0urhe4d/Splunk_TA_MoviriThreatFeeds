#!/bin/bash
#Script that downloads the iblocklist - Bt Proxy Black List
#
#==============================================================================
#Fix error when calling script from Splunk
#==============================================================================

unset LD_LIBRARY_PATH

#==============================================================================
#iblocklist - Bt Proxy Black List
#==============================================================================

logger -t Splunk-iblocklistproxy "iblocklist - Bt Proxy Black List"

wget http://list.iblocklist.com/?list=bt_proxy -O /tmp/IP_proxy.gz

if [ -s /tmp/IP_proxy.gz ]
then
   echo "# Generated: `date`" >  /opt/splunk/etc/apps/moviri-threatfeeds/logs/proxy_black_list.txt

   zcat /tmp/IP_proxy.gz |grep -v \# | grep -v "^$"| cut -d: -f 2 | awk -F- '{system("/opt/splunk/etc/apps/moviri-threatfeeds/bin/prips -c "$1" "$2)}' | sed 's/$/ iBlocklist BT Proxy/'  >> /opt/splunk/etc/apps/moviri-threatfeeds/logs/proxy_black_list.txt
fi

rm /tmp/IP_proxy.gz
