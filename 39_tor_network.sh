#!/bin/bash

# Copyright 2023 Angrybee.tech (https://angrybee.tech)
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

exec > ./39_tor_network.log 2>&1

echo "######################################"
echo "#     Install Tor network - START     #"
echo "######################################"


apt install -y tor

echo "#Step 10: Configure /etc/tor/torrc --> MSG: RunAsDaemon 1"
numline3=$(cat -n /etc/tor/torrc | grep 'RunAsDaemon' | awk '{print $1;}')
sed -i ${numline3}'s/.*/RunAsDaemon 1/' /etc/tor/torrc

echo "#Step 10: Restart Tor service --> systemctl restart tor"
systemctl restart tor

echo "######################################"
echo "#     Install Tor network - END       #"
echo "######################################" 
