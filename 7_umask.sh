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

exec > ./7_umask.log 2>&1


echo "######################################"
echo "#   Step 7: Configure UMASK - START  #"
echo "######################################"

echo "#Step 7: Configure UMASK --> MSG: Save /etc/profile"
cp /etc/profile ./profile.save

echo "#Step 7: Configure UMASK --> MSG: Write umask 027 to /etc/profile"
sed -i '1iumask 027' /etc/profile

echo "#Step 7: Configure UMASK --> MSG: Display /etc/profile content"
cat /etc/profile

echo "#Step 7: Configure UMASK --> MSG: Save /etc/bash.bashrc"
cp /etc/bash.bashrc ./bash.bashrc.save

echo "#Step 7: Configure UMASK --> MSG: Write umask 027 to /etc/bash.bashrc"
sed -i '1iumask 027' /etc/bash.bashrc

echo "#Step 7: Configure UMASK --> MSG: Display /etc/bash.bashrc content"
cat /etc/bash.bashrc

echo "####################################"
echo "#   Step 7: Configure UMASK - END  #"
echo "####################################"
