#!/bin/bash

# Return help if incorrect # of arguments supplied
if [ $# != 2 ]; then
  echo "Usage: .update_ip.sh [connection_name] [new_ip]"
  exit 0
fi

# Get line number of desired host
LINE=`grep -n $1 /home/chris/.ssh/config |cut -f1 -d:`

# Adjust for IP's line number
NUM=`expr $LINE + 2`

sed -i -e ""$NUM"s/\([0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\)/$2/" /home/chris/.ssh/config
