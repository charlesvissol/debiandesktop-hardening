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

exec > ./3_libpam.log 2>&1

echo "#######################################"
echo "#   Step 3: Install PAM libs - START  #"
echo "#######################################"


echo "#Step 3: Install PAM libs --> MSG: Install libpam-pwquality"
sudo apt install -y libpam-pwquality

echo "#Step 3: Install PAM libs --> MSG: Install libpam-shield"
sudo apt install -y libpam-shield

echo "#Step 3: Install PAM libs --> MSG: Install libpam-tmpdir"
sudo apt install -y libpam-tmpdir

echo "#Step 3: Install PAM libs --> MSG: Verification"
apt search libpam-pwquality
apt search libpam-shield
apt search libpam-tmpdir

echo "#####################################"
echo "#   Step 3: Install PAM libs - END  #"
echo "#####################################"
