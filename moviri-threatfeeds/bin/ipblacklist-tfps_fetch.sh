#!/bin/bash
#Script that downloads the Malc0de - Malc0de Black List
#
#==============================================================================
#Fix error when calling script from Splunk
#==============================================================================

unset LD_LIBRARY_PATH

#==============================================================================
#Malc0de - Malc0de Black List
#==============================================================================

logger -t Splunk-malcode-blacklist "Malc0de - Malc0de Black List"

wget http://malc0de.com/bl/IP_Blacklist.txt -O /tmp/IP_Blacklist.txt --no-check-certificate -N

if [ -s /tmp/IP_Blacklist.txt ]
then
   echo "# Generated: `date`" >  /opt/splunk/etc/apps/moviri-threatfeeds/logs/malc0de_black_list.txt

   cat /tmp/IP_Blacklist.txt | sed -n '/^[0-9]/p' | sed 's/$/ Malc0de IP/' >> /opt/splunk/etc/apps/moviri-threatfeeds/logs/malc0de_black_list.txt
fi

rm /tmp/IP_Blacklist.txt
