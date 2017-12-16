#!/bin/bash
#Script that downloads the AlienVault - IP Reputation Database
#
#==============================================================================
#Fix error when calling script from Splunk
#==============================================================================

unset LD_LIBRARY_PATH

#==============================================================================
#AlienVault - IP Reputation Database
#==============================================================================

logger -t Splunk-avipreplist "AlienVault - IP Reputation Database"

wget https://reputation.alienvault.com/reputation.snort.gz -P /tmp --no-check-certificate -N

gzip -d /tmp/reputation.snort.gz

if [ -s /tmp/reputation.snort ]
then
   echo "# Generated: `date`" > /opt/splunk/etc/apps/moviri-threatfeeds/logs/av_ip_rep_list.txt

   cat /tmp/reputation.snort | sed -n '/^[0-9]/p' | sed "s/# //">> /opt/splunk/etc/apps/moviri-threatfeeds/logs/av_ip_rep_list.txt
fi

rm /tmp/reputation.snort
