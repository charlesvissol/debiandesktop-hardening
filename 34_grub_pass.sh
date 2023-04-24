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


echo "#############################################################"
echo "#   Step 34: Setting up a passwphrase for grub init - START #"
echo "#############################################################"

exec > ./34_grub_pass.log 2>&1

# root privileges
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

# install grub if not already
if ! dpkg -s grub-pc > /dev/null 2>&1; then
    echo "Installing GRUB..."
    apt-get update
    apt-get install -y grub-pc
fi

# set boot loader password
echo "Setting boot loader password..."
echo "Enter the desired password:"
read -s password
echo "Re-enter the password to confirm:"
read -s password_confirmation

if [ "$password" == "$password_confirmation" ]; then
    grub-mkpasswd-pbkf2 | tee /boot/grub/password.txt > /dev/null
    grub-mkconfig -o /boot/grub/grub.cfg
    sed -i '/set superusers="root"/a\password_pbkdf2 root $(cat /boot/grub/password.txt)' /etc/grub.d/00_header
    update-grub
    echo "Boot loader password set successfully!"
else
    echo "Passwords do not match. Please try again."
fi    

echo "#############################################################"s
echo "#   Step 34: Setting up a passwphrase for grub init - END   #"
echo "#############################################################"
