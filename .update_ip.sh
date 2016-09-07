#!/bin/bash

# Return help if incorrect # of arguments supplied
if [ $# != 2 ]; then
  echo "Usage: .update_ip.sh [connection_name] [new_ip]"
  exit 0
fi

# Get line number of desired host
LINE=`grep -n $1 /home/chris/.ssh/config |cut -f1 -d:`

if [ -z "$LINE" ]; then
  echo Server \"$1\" could not be found in ssh config. Exiting.
  exit 1
fi

# Adjust for IP's line number
NUM=`expr $LINE + 2`

sed -i -e ""$NUM"s/\([0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\)/$2/" /home/chris/.ssh/config

echo Successfully updated \"$1\" with IP address $2 in ssh config.

# Also adjust filezilla config
unset LINE
LINE=`grep -n $1 /home/chris/.config/filezilla/sitemanager.xml |cut -f1 -d: | head -n 1`

if [ -z "$LINE" ]; then
  echo Server \"$1\" could not be found in filezilla config. Exiting.
  exit 1
fi

# Adjust for IP line number
NUM=`expr $LINE - 12`

sed -i -e ""$NUM"s/\([0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\)/$2/" /home/chris/.config/filezilla/sitemanager.xml

echo Successfully updated \"$1\" with IP address $2 in filezilla config.
