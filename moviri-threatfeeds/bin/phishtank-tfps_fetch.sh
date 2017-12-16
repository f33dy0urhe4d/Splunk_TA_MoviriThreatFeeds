#!/bin/bash
#Script that downloads the Phishing Site List 
#
#==============================================================================
#Fix error when calling script from Splunk
#==============================================================================

unset LD_LIBRARY_PATH

#==============================================================================
#PhishTank - Phishing Site List
#==============================================================================

logger -t Splunk-TFPS-PhishTank "Phishing Site List"

wget http://data.phishtank.com/data/online-valid.csv.gz -O /tmp/phish_tank.gz

if [ -s /tmp/phish_tank.gz ]
then
   echo "# Generated: `date`" >  /opt/splunk/etc/apps/moviri-threatfeeds/logs/phish_tank.domain

   zcat /tmp/phish_tank.gz | sed -n '/^[0-9]/p' | cut -d, -f 2 | sed 's/^/Site=/' | sed 's/$/ Phishing Site List/' >> /opt/splunk/etc/apps/moviri-threatfeeds/logs/phish_tank.domain
fi

rm /tmp/phish_tank.gz
