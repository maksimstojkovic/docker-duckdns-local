#!/bin/sh

# Check variables TOKEN, DOMAIN, INTERFACE
if [ -z "$TOKEN" ]; then
	echo "ERROR: Variable TOKEN is unset."
	exit 1
fi

if [ -z "$SUBDOMAIN" ]; then
	echo "ERROR: Variable SUBDOMAIN is unset."
	exit 1
fi

if [ -z "$DELAY" ]; then
	echo "ERROR: Variable DELAY is unset."
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
echo "TOKEN: $TOKEN"
echo "DOMAIN: $SUBDOMAIN"
echo "DELAY: $DELAY minute(s)"
echo "INTERFACE: $INTERFACE"

# Suggest longer delay if below 5 minutes
if [ "$DELAY" -lt 5 ]; then
  echo "WARNING: Consider using a delay of at least 5 minutes."
fi

# Start automatic ip address updates
/bin/sh /scripts/update.sh
