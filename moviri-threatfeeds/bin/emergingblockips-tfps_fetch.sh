#!/bin/bash 
#Script that downloads the Emerging Threats - Shadowserver C&C List, Spamhaus DROP Nets, Dshield Top Attackers

#==============================================================================
#Fix error when calling script from Splunk
#==============================================================================

unset LD_LIBRARY_PATH

#==============================================================================
#Emerging Threats - Shadowserver C&C List, Spamhaus DROP Nets, Dshield Top
#Attackers
#==============================================================================

logger -t Splunk-emergingthreats "Emerging Threats - Feodo, Zeus, Palevo, Spamhaus DROP Nets, Dshield Top Attackers"

wget http://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt -O /tmp/emerging-Block-IPs.txt --no-check-certificate -N

if [ -s /tmp/emerging-Block-IPs.txt ]
then
   echo "# Generated: `date`" > /opt/splunk/etc/apps/moviri-threatfeeds/logs/emerging_threats_feodo_ips.txt
   cat /tmp/emerging-Block-IPs.txt | sed -e '1,/# \Feodo/d' -e '/#/,$d' | sed -n '/^[0-9]/p' | sed 's/$/ Feodo Network/' >>  /opt/splunk/etc/apps/moviri-threatfeeds/logs/emerging_threats_feodo_ips.txt

   echo "# Generated: `date`" > /opt/splunk/etc/apps/moviri-threatfeeds/logs/emerging_threats_zeus_ips.txt
   cat /tmp/emerging-Block-IPs.txt | sed -e '1,/# \Zeus/d' -e '/#/,$d' | sed -n '/^[0-9]/p' | sed 's/$/ Zeus Network/' >>  /opt/splunk/etc/apps/moviri-threatfeeds/logs/emerging_threats_zeus_ips.txt

   echo "# Generated: `date`" > /opt/splunk/etc/apps/moviri-threatfeeds/logs/emerging_threats_spyeye_ips.txt
   cat /tmp/emerging-Block-IPs.txt | sed -e '1,/# \Spyeye/d' -e '/#/,$d' | sed -n '/^[0-9]/p' | sed 's/$/ Spyeye Network/' >>  /opt/splunk/etc/apps/moviri-threatfeeds/logs/emerging_threats_spyeye_ips.txt

   echo "# Generated: `date`" > /opt/splunk/etc/apps/moviri-threatfeeds/logs/emerging_threats_palevo_ips.txt
   cat /tmp/emerging-Block-IPs.txt | sed -e '1,/# \Palevo/d' -e '/#/,$d' | sed -n '/^[0-9]/p' | sed 's/$/ Palevo Network/' >>  /opt/splunk/etc/apps/moviri-threatfeeds/logs/emerging_threats_palevo_ips.txt

   echo "# Generated: `date`" > /opt/splunk/etc/apps/moviri-threatfeeds/logs/emerging_threats_spamhaus_drop_ips.txt
   cat /tmp/emerging-Block-IPs.txt | sed -e '1,/#Spamhaus DROP Nets/d' -e '/#/,$d' | sed -n '/^[0-9]/p' | sed 's/$/ Spamhaus Network/' >> /opt/splunk/etc/apps/moviri-threatfeeds/logs/emerging_threats_spamhaus_drop_ips.txt

   echo "# Generated: `date`" > /opt/splunk/etc/apps/moviri-threatfeeds/logs/emerging_threats_dshield_ips.txt
   cat /tmp/emerging-Block-IPs.txt | sed -e '1,/#Dshield Top Attackers/d' -e '/#/,$d' | sed -n '/^[0-9]/p' | sed 's/$/ Dshield Block IPS/' >> /opt/splunk/etc/apps/moviri-threatfeeds/logs/emerging_threats_dshield_ips.txt
fi

rm /tmp/emerging-Block-IPs.txt
