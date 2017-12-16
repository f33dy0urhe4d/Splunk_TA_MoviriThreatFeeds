#!/bin/bash
#Script that downloads the DShield Recommended Block List
#
#==============================================================================
#Fix error when calling script from Splunk
#==============================================================================

unset LD_LIBRARY_PATH

#==============================================================================
#DShield - Recommended Block List
#==============================================================================

logger -t Splunk-TFPS-DShield_block_list "DShield - Recommended Block List"

wget https://isc.sans.edu/block.txt -O /tmp/dshield_block_list --no-check-certificate -N

if [ -s /tmp/dshield_block_list ]
then
   echo "# Generated: `date`" >  /opt/splunk/etc/apps/moviri-threatfeeds/logs/dshield_block_list.txt

   cat /tmp/dshield_block_list |grep -v \# | sed -n '/^[0-9]/p' | cut -f 1,2 | awk -F- '{system("/opt/splunk/etc/apps/moviri-threatfeeds/bin/prips -c "$1" "$2)}' | sed 's/$/ DShield Block List/'  >> /opt/splunk/etc/apps/moviri-threatfeeds/logs/dshield_block_list.txt
fi

rm /tmp/dshield_block_list
