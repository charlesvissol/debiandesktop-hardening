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

exec > ./34_grub_pass.log 2>&1

echo "#############################################################"
echo "#   Step 34: Setting up a passwphrase for grub init - START #"
echo "#############################################################"

# set boot loader password
echo "Setting boot loader password..."
echo "Enter the desired password:"
read -s password
echo "Re-enter the password to confirm:"
read -s password_confirmation

if [ "$password" == "$confirm_password" ] ; then
    hash=$(echo -e "'$password'\n'$confirm_password'" | grub-mkpasswd-pbkdf2 | awk '/^PBKDF2 hash of/ {print $NF}')
    
    echo "cat << EOF" >> /etc/grub.d/00_header
    echo 'set superusers="'$username'"' >> /etc/grub.d/00_header
    echo "password_pbkdf2 $username $hash" >> /etc/grub.d/00_header
    echo "EOF" >> /etc/grub.d/00_header
fi  

echo "#############################################################"s
echo "#   Step 34: Setting up a passwphrase for grub init - END   #"
echo "#############################################################"
