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


echo "###############################"
echo "# TorghostNG : manage - START #"
echo "###############################"

echo "This script is starting or stopping network encapsulation in tor"

echo "Enter if you want to start or stop TorghostNG (start/stop)"
read status

if [ $status == "start" ]
then
	torghostng -s
elif [ $status == "stop" ]
then
	torghostng -x
else
	echo "error wrong typing"
fi


echo "###############################"
echo "#  TorghostNG : manage - END  #"
echo "###############################"
