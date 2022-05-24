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


echo "##################################################"
echo "#   Step 00: Download external resources - START #"
echo "##################################################"

cd ./


echo "Step 00: Install and configuration Tor Browser --> MSG: Download MarkText editor DEB package"
curl -O -v https://github.com/marktext/marktext/releases/download/v0.17.1/marktext-amd64.deb

echo "Step 00: Install and configuration Tor Browser --> MSG: Download Tor Browser installer"
curl -O -v https://www.torproject.org/dist/torbrowser/11.0.11/tor-browser-linux64-11.0.11_en-US.tar.xz

echo "Step 00: Install and configuration Tor Browser --> MSG: Download VirtualBox packages"
curl -O -v https://download.virtualbox.org/virtualbox/6.1.34/virtualbox-6.1_6.1.34-150636.1~Debian~bullseye_amd64.deb
curl -O -v https://download.virtualbox.org/virtualbox/6.1.34/Oracle_VM_VirtualBox_Extension_Pack-6.1.34.vbox-extpack

echo "################################################"
echo "#   Step 00: Download external resources - END #"
echo "################################################"

