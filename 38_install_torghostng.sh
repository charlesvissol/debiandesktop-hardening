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

exec > ./install_torghostng.log 2>&1

echo "######################################"
echo "#     Install TorghostNG - START     #"
echo "######################################"


#install torghostng
git clone https://github.com/Zopolis4/TorghostNG

cd TorghostNG/

python3 install.py


echo "######################################"
echo "#     Install TorghostNG - END       #"
echo "######################################"
