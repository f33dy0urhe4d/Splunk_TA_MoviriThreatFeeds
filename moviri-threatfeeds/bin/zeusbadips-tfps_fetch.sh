#!/bin/bash
#Script that downloads the ZeuS Tracker - Bad IPS 
#
#==============================================================================
#Fix error when calling script from Splunk
#==============================================================================

unset LD_LIBRARY_PATH

#==============================================================================
#ZeuS Tracker - Bad IPS
#==============================================================================

logger -t Splunk-TFPS-ZeusBadIPS "ZeuS Tracker - Bad IPS"

wget https://zeustracker.abuse.ch/blocklist.php?download=badips -O /tmp/zeustracker_badips.txt --no-check-certificate -N

if [ -s /tmp/zeustracker_badips.txt ]
then
  echo "# Generated: `date`" > /opt/splunk/etc/apps/moviri-threatfeeds/logs/zeus_bad_ips.txt

  cat /tmp/zeustracker_badips.txt | sed -n '/^[0-9]/p' | sed 's/$/ Zeus Bad IPS/' >> /opt/splunk/etc/apps/moviri-threatfeeds/logs/zeus_bad_ips.txt
fi

rm /tmp/zeustracker_badips.txt
