#!/bin/bash

# Copyright 2022 Angrybee.tech (https://angrybee.tech)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Suggested answers when your system is hardened:
#   /etc/issue = n
#   /etc/issue.net = n
#   restart packages during upgrade = yes
#   /etc/login.defs = n
#   /etc/security/limits.conf = n
#   /etc/apparmor.d/firejail-default = n
#   /etc/sudoers = n
#   /etc/rsyslog.conf = n
#   aide.conf = keep the local version currently installed
#   /etc/audit/auditd.conf = n
#


echo -n "Enter your current username/logon: "
read usernameroot



# Make sure you up-to-date
sudo apt update
sudo apt upgrade
sudo apt full-upgrade
sudo apt autoremove

mkdir /home/$usernameroot/apt_backup
mkdir /home/$usernameroot/apt_backup/sources.list.d
sudo cp -v /etc/apt/sources.list /home/$usernameroot/apt_backup/
sudo cp -vr /etc/apt/sources.list.d/ /home/$usernameroot/sources.list.d/

chown -R $usernameroot:$usernameroot /home/$usernameroot/apt_backup

numline1=$(cat -n /etc/apt/sources.list | grep 'deb http://deb.debian.org/debian/ bullseye main' | awk '{print $1;}')
sed -i ${numline1}'s/.*/#deb http:\/\/deb.debian.org\/debian\/ bullseye main/' /etc/apt/sources.list

numline2=$(cat -n /etc/apt/sources.list | grep 'deb-src http://deb.debian.org/debian/ bullseye main' | awk '{print $1;}')
sed -i ${numline2}'s/.*/#deb-src http:\/\/deb.debian.org\/debian\/ bullseye main/' /etc/apt/sources.list

numline3=$(cat -n /etc/apt/sources.list | grep 'deb http://security.debian.org/debian-security bullseye-security main' | awk '{print $1;}')
sed -i ${numline3}'s/.*/#deb http:\/\/security.debian.org\/debian-security\/ bullseye-security main/' /etc/apt/sources.list

numline4=$(cat -n /etc/apt/sources.list | grep 'deb-src http://security.debian.org/debian-security bullseye-security main' | awk '{print $1;}')
sed -i ${numline4}'s/.*/#deb-src http:\/\/security.debian.org\/debian-security bullseye-security main/' /etc/apt/sources.list

numline5=$(cat -n /etc/apt/sources.list | grep 'deb http://deb.debian.org/debian/ bullseye-updates main' | awk '{print $1;}')
sed -i ${numline5}'s/.*/#deb http:\/\/deb.debian.org\/debian\/ bullseye-updates main/' /etc/apt/sources.list

numline6=$(cat -n /etc/apt/sources.list | grep 'deb-src http://deb.debian.org/debian/ bullseye-updates main' | awk '{print $1;}')
sed -i ${numline6}'s/.*/#deb-src http:\/\/deb.debian.org\/debian\/ bullseye-updates main/' /etc/apt/sources.list


echo "deb http://deb.debian.org/debian/ bookworm main" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian/ bookworm main" >> /etc/apt/sources.list

echo "deb http://security.debian.org/debian-security bookworm-security main" >> /etc/apt/sources.list
echo "deb-src http://security.debian.org/debian-security bookworm-security main" >> /etc/apt/sources.list

echo "deb http://deb.debian.org/debian/ bookworm-updates main" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian/ bookworm-updates main" >> /etc/apt/sources.list

echo "deb http://deb.debian.org/debian bookworm non-free non-free-firmware" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian bookworm non-free non-free-firmware" >> /etc/apt/sources.list

echo "deb http://deb.debian.org/debian-security bookworm-security non-free non-free-firmware" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian-security bookworm-security non-free non-free-firmware" >> /etc/apt/sources.list

echo "deb http://deb.debian.org/debian bookworm-updates non-free non-free-firmware" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian bookworm-updates non-free non-free-firmware" >> /etc/apt/sources.list

sudo rm /var/cache/apt/archives/*.deb


sudo apt update
sudo apt full-upgrade
# upgrade existing packages
sudo apt upgrade --without-new-pkgs -y





