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

echo -n "Enter username to add to root (only One for this system!): "
read usernameroot

exec > ./21_tor_browser.log 2>&1

echo "############################################################"
echo "#   Step 21: Install and configuration Tor Browser - START #"
echo "############################################################"



echo "Step 21: Install and configuration Tor Browser --> MSG: Create Softs directory"
mkdir /home/$usernameroot/Softs

echo "Step 21: Install and configuration Tor Browser --> MSG: Add right to current user"
chown $usernameroot:$usernameroot /home/$usernameroot/Softs

echo "Step 21: Install and configuration Tor Browser --> MSG: Copy the binaries"
cp ./tor-browser-linux64-11.0.11_en-US.tar.xz /home/$usernameroot/Softs

echo "Step 21: Install and configuration Tor Browser --> MSG: Set user rights"
chown $usernameroot:$usernameroot /home/$usernameroot/Softs/tor-browser-linux64-11.0.11_en-US.tar.xz

echo "Step 21: Install and configuration Tor Browser --> MSG: Go to Tor Browser folder"
cd /home/$usernameroot/Softs

echo "Step 21: Install and configuration Tor Browser --> MSG: Deploy resources"
tar xvf /home/$usernameroot/Softs/tor-browser-linux64-11.0.11_en-US.tar.xz

echo "Step 21: Install and configuration Tor Browser --> MSG: Set rights to "$usernameroot
chown -R $usernameroot:$usernameroot /home/$usernameroot/Softs/tor-browser_en-US

echo "Step 21: Install and configuration Tor Browser --> MSG: create and copy shortcut to "$usernameroot" Desktop"
touch /home/$usernameroot/Desktop/tor-browser.desktop
chown $usernameroot:$usernameroot /home/$usernameroot/Desktop/tor-browser.desktop
chmod ugo+x /home/$usernameroot/Desktop/tor-browser.desktop

echo "Step 21: Install and configuration Tor Browser --> MSG: Write custom content of *.desktop file"
echo "[Desktop Entry]" >> /home/$usernameroot/Desktop/tor-browser.desktop
echo "Type=Application" >> /home/$usernameroot/Desktop/tor-browser.desktop
echo "Name=Tor Browser" >> /home/$usernameroot/Desktop/tor-browser.desktop
echo "GenericName=Web Browser" >> /home/$usernameroot/Desktop/tor-browser.desktop
echo "Comment=Tor Browser is +1 for privacy and −1 for mass surveillance" >> /home/$usernameroot/Desktop/tor-browser.desktop
echo "Categories=Network;WebBrowser;Security;" >> /home/$usernameroot/Desktop/tor-browser.desktop
echo "Exec=sh -c '\"/home/"$usernameroot"/Softs/tor-browser_en-US/Browser/start-tor-browser\" --detach || ([ !  -x \"/home/"$usernameroot"/Softs/tor-browser_en-US/Browser/start-tor-browser\" ] && \"$(dirname \"$*\")\"/Browser/start-tor-browser --detach)' dummy %k" >> /home/$usernameroot/Desktop/tor-browser.desktop
echo "X-TorBrowser-ExecShell=./Browser/start-tor-browser --detach" >> /home/$usernameroot/Desktop/tor-browser.desktop
echo "Icon=/home/"$usernameroot"/Softs/tor-browser_en-US/Browser/browser/chrome/icons/default/default128.png" >> /home/$usernameroot/Desktop/tor-browser.desktop
echo "StartupWMClass=Tor Browser" >> /home/$usernameroot/Desktop/tor-browser.desktop


echo "##########################################################"
echo "#   Step 21: Install and configuration Tor Browser - END #"
echo "##########################################################"


