#!/bin/sh

# Update IP
IP=$(/sbin/ifconfig $INTERFACE | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')

# Loop update process
while :; do
  echo url="https://www.duckdns.org/update?domains=${SUBDOMAIN}&token=${TOKEN}&ip=${IP}" | curl -ks -o /scripts/duck.log -K -

  # Check that log was created (successful curl) and
  if [ ! -f "/scripts/duck.log" ]; then
    echo "ERROR: Failed to create Duck DNS log file, check your TOKEN and DOMAIN."
    exit 1
  fi

  if [ "$(cat /scripts/duck.log)" != "OK" ]; then
    echo "ERROR: IP address update failed, check your TOKEN and DOMAIN."
    exit 1
  fi

  # Wait before updating ip address again
  echo "Successfully updated IP address."
  echo "Sleeping for $DELAY minute(s)."
  sleep $((${DELAY} * 60))
done
