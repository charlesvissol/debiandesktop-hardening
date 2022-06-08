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

exec > ./10_sysctl_conf.log 2>&1

echo "##################################################"
echo "#   Step 10: Configure /etc/sysctl.conf - START  #"
echo "##################################################"


echo "#Step 10: Configure /etc/sysctl.conf --> MSG: backup /etc/sysctl.conf to current directory"
cp /etc/sysctl.conf ./sysctl.conf.save

echo "#Step 10: Configure /etc/sysctl.conf --> MSG: net.ipv4.conf.default.rp_filter=1"
numline1=$(cat -n /etc/sysctl.conf | grep 'net.ipv4.conf.default.rp_filter' | awk '{print $1;}')
sed -i ${numline1}'s/.*/net.ipv4.conf.default.rp_filter=1/' /etc/sysctl.conf

echo "#Step 10: Configure /etc/sysctl.conf --> MSG: net.ipv4.conf.all.rp_filter=1"
numline2=$(cat -n /etc/sysctl.conf | grep 'net.ipv4.conf.all.rp_filter' | awk '{print $1;}')
sed -i ${numline2}'s/.*/net.ipv4.conf.all.rp_filter=1/' /etc/sysctl.conf

echo "#Step 10: Configure /etc/sysctl.conf --> MSG: net.ipv4.tcp_syncookies=1"
numline3=$(cat -n /etc/sysctl.conf | grep 'net.ipv4.tcp_syncookies' | awk '{print $1;}')
sed -i ${numline3}'s/.*/net.ipv4.tcp_syncookies=1/' /etc/sysctl.conf

echo "#Step 10: Configure /etc/sysctl.conf --> MSG: net.ipv4.conf.all.accept_redirects = 0"
numline4=$(cat -n /etc/sysctl.conf | grep 'net.ipv4.conf.all.accept_redirects' | awk '{print $1;}')
sed -i ${numline4}'s/.*/net.ipv4.conf.all.accept_redirects = 0/' /etc/sysctl.conf

echo "#Step 10: Configure /etc/sysctl.conf --> MSG: net.ipv6.conf.all.accept_redirects = 0"
numline5=$(cat -n /etc/sysctl.conf | grep 'net.ipv6.conf.all.accept_redirects' | awk '{print $1;}')
sed -i ${numline5}'s/.*/net.ipv6.conf.all.accept_redirects = 0/' /etc/sysctl.conf

echo "#Step 10: Configure /etc/sysctl.conf --> MSG: net.ipv4.conf.all.send_redirects = 0"
numline6=$(cat -n /etc/sysctl.conf | grep 'net.ipv4.conf.all.send_redirects' | awk '{print $1;}')
sed -i ${numline6}'s/.*/net.ipv4.conf.all.send_redirects = 0/' /etc/sysctl.conf

echo "#Step 10: Configure /etc/sysctl.conf --> MSG: net.ipv4.conf.all.log_martians = 1"
numline7=$(cat -n /etc/sysctl.conf | grep 'net.ipv4.conf.all.log_martians' | awk '{print $1;}')
sed -i ${numline7}'s/.*/net.ipv4.conf.all.log_martians = 1/' /etc/sysctl.conf

echo "#Step 10: Configure /etc/sysctl.conf --> MSG: net.ipv4.ip_forward=0"
numline8=$(cat -n /etc/sysctl.conf | grep 'net.ipv4.ip_forward' | awk '{print $1;}')
sed -i ${numline8}'s/.*/net.ipv4.ip_forward=0/' /etc/sysctl.conf

echo "#Step 10: Configure /etc/sysctl.conf --> MSG: net.ipv4.conf.all.secure_redirects = 0"
numline9=$(cat -n /etc/sysctl.conf | grep 'net.ipv4.conf.all.secure_redirects' | awk '{print $1;}')
sed -i ${numline9}'s/.*/net.ipv4.conf.all.secure_redirects = 0/' /etc/sysctl.conf


echo "#Step 10: Configure sudo sysctl --> MSG: Get net.ipv4.conf.all.send_redirects value"
sudo sysctl -a | grep net.ipv4.conf.all.send_redirects
echo "#Step 10: Configure sudo sysctl --> MSG: Write net.ipv4.conf.all.send_redirects = 0"
sudo sysctl -w net.ipv4.conf.all.send_redirects=0

echo "#Step 10: Configure sudo sysctl --> MSG: Get net.ipv4.conf.default.send_redirects value"
sudo sysctl -a | grep net.ipv4.conf.default.send_redirects
echo "#Step 10: Configure sudo sysctl --> MSG: Write net.ipv4.conf.default.send_redirects = 0"
sudo sysctl -w net.ipv4.conf.default.send_redirects=0

echo "#Step 10: Configure sudo sysctl --> MSG: Get net.ipv4.conf.all.accept_source_route value"
sudo sysctl -a | grep net.ipv4.conf.all.accept_source_route
echo "#Step 10: Configure sudo sysctl --> MSG: Write net.ipv4.conf.all.accept_source_route = 0"
sudo sysctl -w net.ipv4.conf.all.accept_source_route=0

echo "#Step 10: Configure sudo sysctl --> MSG: Get net.ipv4.conf.default.accept_source_route value"
sudo sysctl -a | grep net.ipv4.conf.default.accept_source_route
echo "#Step 10: Configure sudo sysctl --> MSG: Write net.ipv4.conf.default.accept_source_route = 0"
sudo sysctl -w net.ipv4.conf.default.accept_source_route=0

echo "#Step 10: Configure sudo sysctl --> MSG: Get net.ipv4.conf.all.accept_redirects value"
sudo sysctl -a | grep net.ipv4.conf.all.accept_redirects
echo "#Step 10: Configure sudo sysctl --> MSG: Write net.ipv4.conf.all.accept_redirects = 0"
sudo sysctl -w net.ipv4.conf.all.accept_redirects=0

echo "#Step 10: Configure sudo sysctl --> MSG: Get net.ipv4.conf.default.accept_redirects value"
sudo sysctl -a | grep net.ipv4.conf.default.accept_redirects
echo "#Step 10: Configure sudo sysctl --> MSG: Write net.ipv4.conf.default.accept_redirects = 0"
sudo sysctl -w net.ipv4.conf.default.accept_redirects=0

echo "#Step 10: Configure sudo sysctl --> MSG: Get net.ipv4.conf.all.secure_redirects value"
sudo sysctl -a | grep net.ipv4.conf.all.secure_redirects
echo "#Step 10: Configure sudo sysctl --> MSG: Write net.ipv4.conf.all.secure_redirects = 0"
sudo sysctl -w net.ipv4.conf.all.secure_redirects=0

echo "#Step 10: Configure sudo sysctl --> MSG: Get net.ipv4.conf.default.secure_redirects value"
sudo sysctl -a | grep net.ipv4.conf.default.secure_redirects
echo "#Step 10: Configure sudo sysctl --> MSG: Write net.ipv4.conf.default.secure_redirects = 0"
sudo sysctl -w net.ipv4.conf.default.secure_redirects=0

echo "#Step 10: Configure sudo sysctl --> MSG: Get net.ipv4.conf.all.log_martians value"
sudo sysctl -a | grep net.ipv4.conf.all.log_martians
echo "#Step 10: Configure sudo sysctl --> MSG: Write net.ipv4.conf.all.log_martians = 1"
sudo sysctl -w net.ipv4.conf.all.log_martians=1

echo "#Step 10: Configure sudo sysctl --> MSG: Get net.ipv4.conf.default.log_martians value"
sudo sysctl -a | grep net.ipv4.conf.default.log_martians
echo "#Step 10: Configure sudo sysctl --> MSG: Write net.ipv4.conf.default.log_martians = 1"
sudo sysctl -w net.ipv4.conf.default.log_martians=1

#echo "#Step 10: Configure sudo sysctl --> MSG: Write net.ipv4.icmp_echo_ignore_broadcast = 1"
#sudo sysctl -w net.ipv4.icmp_echo_ignore_broadcast=1

echo "#Step 10: Configure sudo sysctl --> MSG: Get net.ipv4.icmp_ignore_bogus_error_responses value"
sudo sysctl -a | grep net.ipv4.icmp_ignore_bogus_error_responses
echo "#Step 10: Configure sudo sysctl --> MSG: Write net.ipv4.icmp_ignore_bogus_error_responses = 1"
sudo sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1

echo "#Step 10: Configure sudo sysctl --> MSG: Get net.ipv6.conf.all.accept_ra value"
sudo sysctl -a | grep net.ipv6.conf.all.accept_ra
echo "#Step 10: Configure sudo sysctl --> MSG: Write net.ipv6.conf.all.accept_ra = 1"
sudo sysctl -w net.ipv6.conf.all.accept_ra=1

echo "#Step 10: Configure sudo sysctl --> MSG: Get net.ipv6.conf.default.accept_ra value"
sudo sysctl -a | grep net.ipv6.conf.default.accept_ra
echo "#Step 10: Configure sudo sysctl --> MSG: Write net.ipv6.conf.default.accept_ra = 1"
sudo sysctl -w net.ipv6.conf.default.accept_ra=1

echo "#Step 10: Configure /etc/sysctl.conf --> MSG: Apply changes"
sudo sysctl -p

echo "#Step 10: Configure /etc/sysctl.conf --> MSG: Display /etc/sysctl.conf modified"
cat /etc/sysctl.conf

echo "#Step 10: Configure sudo sysctl --> MSG: Get new sudo sysctl values"
sudo sysctl -a | grep net.ipv4.conf.all.send_redirects
sudo sysctl -a | grep net.ipv4.conf.default.send_redirects
sudo sysctl -a | grep net.ipv4.conf.all.accept_source_route
sudo sysctl -a | grep net.ipv4.conf.default.accept_source_route
sudo sysctl -a | grep net.ipv4.conf.all.accept_redirects
sudo sysctl -a | grep net.ipv4.conf.default.accept_redirects
sudo sysctl -a | grep net.ipv4.conf.all.secure_redirects
sudo sysctl -a | grep net.ipv4.conf.default.secure_redirects
sudo sysctl -a | grep net.ipv4.conf.all.log_martians
sudo sysctl -a | grep net.ipv4.conf.default.log_martians
sudo sysctl -a | grep net.ipv4.icmp_ignore_bogus_error_responses
sudo sysctl -a | grep net.ipv6.conf.all.accept_ra
sudo sysctl -a | grep net.ipv6.conf.default.accept_ra


echo "################################################"
echo "#   Step 10: Configure /etc/sysctl.conf - END  #"
echo "################################################"











