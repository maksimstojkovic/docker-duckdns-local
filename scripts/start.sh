#!/bin/sh

# Check variables DUCKDNS_TOKEN, DUCKDNS_DOMAIN, INTERFACE
if [ -z "$DUCKDNS_TOKEN" ]; then
	echo "ERROR: Variable DUCKDNS_TOKEN is unset."
	exit 1
fi

if [ -z "$DUCKDNS_SUBDOMAIN" ]; then
	echo "ERROR: Variable DUCKDNS_SUBDOMAIN is unset."
	exit 1
fi

if [ -z "$INTERFACE" ]; then
	echo "ERROR: Variable INTERFACE is unset."
	exit 1
fi

# Check if running with host network (required for local network ip)
if [ "$(ip a show dev eth0 | grep "@" | wc -l)" -gt 0 ]; then
	echo "ERROR: Not using host network. Use '--network host' in 'docker run' command."
	exit 1
fi

# Check for valid interface
if [ -z "$(ip -o link show | awk -F': ' '{print $2}' | grep $INTERFACE)" ]; then
  echo "ERROR: Invalid interface provided. Valid interfaces are:"
  echo "$(ip -o link show | awk -F': ' '{print $2}')"
  exit 1
fi

# Print variables
echo "DUCKDNS_TOKEN: $DUCKDNS_TOKEN"
echo "DUCKDNS_DOMAIN: $DUCKDNS_SUBDOMAIN"
echo "DUCKDNS_DELAY: $DUCKDNS_DELAY minute(s)"
echo "INTERFACE: $INTERFACE"

# Suggest longer delay if below 5 minutes
if [ "$DUCKDNS_DELAY" -lt 5 ]; then
  echo "WARNING: Consider using a delay of at least 5 minutes."
fi

# Start automatic ip address updates
/bin/sh /scripts/update.sh
