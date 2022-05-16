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

exec > ./23_firewall.log 2>&1

echo "###############################"
echo "#   Step 23: Firewall - START #"
echo "###############################"

apt-get install -y ufw

apt-get install -y gufw


#add rules
ufw default deny incoming
ufw default allow outgoing
ufw default deny routed
sudo ufw deny ssh
sudo ufw allow http
sudo ufw allow https

sudo ufw enable


echo "#############################"
echo "#   Step 23: Firewall - END #"
echo "#############################"


