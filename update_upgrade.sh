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

sudo apt-get update
sudo apt-get upgrade

echo "Status = "$?

echo "Upgrade Ended"

echo "Press 'q' to exit"
count=0
while : ; do
read -n 1 k <&1
if [[ $k = q ]] ; then
    printf "\nQuitting from the program\n"
    kill -9 $PPID

else
    ((count=$count+1))
    printf "\nIterate for $count times\n"
    echo "Press 'q' to exit"
fi
done
