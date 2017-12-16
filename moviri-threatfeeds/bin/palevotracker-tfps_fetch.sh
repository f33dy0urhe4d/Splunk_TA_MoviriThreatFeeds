#!/bin/bash
#Script that downloads the Palevo Tracker - IP Block List
#
#==============================================================================
#Fix error when calling script from Splunk
#==============================================================================

unset LD_LIBRARY_PATH

#==============================================================================
#Palevo Tracker - IP Block List
#==============================================================================

logger -t Splunk-palevo-blocklist "Palevo Tracker - IP Block List"

wget https://palevotracker.abuse.ch/blocklists.php?download=ipblocklist -O /tmp/palevotracker.txt --no-check-certificate -N

if [ -s /tmp/palevotracker.txt ]
then
   echo "# Generated: `date`" > /opt/splunk/etc/apps/moviri-threatfeeds/logs/palevo_ip_block_list.txt

   cat /tmp/palevotracker.txt | sed -n '/^[0-9]/p' | sed 's/$/ Palevo IP/' >> /opt/splunk/etc/apps/moviri-threatfeeds/logs/palevo_ip_block_list.txt
fi

rm /tmp/palevotracker.txt

