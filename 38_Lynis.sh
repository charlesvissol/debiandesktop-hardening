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

exec > ./38_Lynis.log 2>&1

echo "###########################################"
echo "#   Step 33: Install and run Lynis - START #"
echo "###########################################"

echo "Step 33: Install and run Lynis --> MSG: Download the key from central keyserver (requires wget)"
sudo wget -O - https://packages.cisofy.com/keys/cisofy-software-public.key | sudo apt-key add -

echo "Step 33: Install and run Lynis --> MSG: Install HTTPS for repository connection and transport"
sudo apt install apt-transport-https

echo "Step 33: Install and run Lynis --> MSG: Skip downloading translations"
echo 'Acquire::Languages "none";' | sudo tee /etc/apt/apt.conf.d/99disable-translations

echo "Step 33: Install and run Lynis --> MSG: Add the repository"
echo "deb https://packages.cisofy.com/community/lynis/deb/ stable main" | sudo tee /etc/apt/sources.list.d/cisofy-lynis.list

echo "Step 33: Install and run Lynis --> MSG: Install Lynis"
sudo apt update
sudo apt install lynis

echo "Step 33: Install and run Lynis --> MSG: Run Lynis for system audit"
sudo lynis audit system

echo "#########################################"
echo "#   Step 33: Install and run Lynis - END #"
echo "#########################################"
