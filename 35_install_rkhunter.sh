#!/bin/bash

# ask for root privileges
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

sudo apt update

sudo apt install -y rkhunter
