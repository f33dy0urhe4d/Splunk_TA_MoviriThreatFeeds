#!/bin/bash
#Script that downloads the ZeuS Tracker - IP Block List
#
#==============================================================================
#Fix error when calling script from Splunk
#==============================================================================

unset LD_LIBRARY_PATH

#==============================================================================
#ZeuS Tracker - IP Block List
#==============================================================================

logger -t Splunk-zeustracker "ZeuS Tracker - IP Block List"

wget https://zeustracker.abuse.ch/blocklist.php?download=ipblocklist -O /tmp/zeustracker.txt --no-check-certificate -N

if [ -s /tmp/zeustracker_ipblocklist.txt ]
then
   echo "# Generated: `date`" > /opt/splunk/etc/apps/moviri-threatfeeds/logs/zeus_ip_block_list.txt

   cat /tmp/zeustracker_ipblocklist.txt | sed -n '/^[0-9]/p' | sed 's/$/ Zeus IP/' >> /opt/splunk/etc/apps/moviri-threatfeeds/logs/zeus_ip_block_list.txt
fi

rm /tmp/zeustracker.txt
