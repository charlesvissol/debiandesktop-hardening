#!/bin/bash

# ask for root privileges
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

# adjust permissions of cupsd config
sudo chmod 640 /etc/cups/cupsd.config

# add line in config
echo "Listen localhost:631" > /etc/cups/cupsd.conf
