#!/bin/bash

# ask for root privileges
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

# edit config rsyslog
echo "*.* @remote-host:514" > /etc/rsyslog.conf

# restart rsyslog
sudo systemctl restart rsyslog
