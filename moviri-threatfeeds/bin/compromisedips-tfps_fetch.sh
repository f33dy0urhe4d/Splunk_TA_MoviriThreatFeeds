#!/bin/bash
#Script that downloads the Emerging Threats - Compromised IP List
#
#==============================================================================
#Fix error when calling script from Splunk
#==============================================================================

unset LD_LIBRARY_PATH

#==============================================================================
#Emerging Threats - Compromised IP List
#==============================================================================

logger -t Splunk-compromisedips "Emerging Threats - Compromised IP List"

wget http://rules.emergingthreats.net/blockrules/compromised-ips.txt -O /tmp/compromised-ips.txt --no-check-certificate -N

if [ -s /tmp/compromised-ips.txt ]
then 
   echo "# Generated: `date`" > /opt/splunk/etc/apps/moviri-threatfeeds/logs/emerging_threats_compromised_ips.txt

   cat /tmp/compromised-ips.txt | sed -n '/^[0-9]/p' | sed 's/$/ Compromised IP/' >> /opt/splunk/etc/apps/moviri-threatfeeds/logs/emerging_threats_compromised_ips.txt
fi

rm /tmp/compromised-ips.txt
