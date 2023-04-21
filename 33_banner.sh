#!/bin/bash

# ask for root privileges
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

# banner
banner="Warning !! Be Careful about privacy. Data theft unauthorized !"

# add banner in the files
echo "$banner" > /etc/issue
echo "$banner" > /etc/issue.net
