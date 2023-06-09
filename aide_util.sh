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


echo "*** WELCOME ON THE AIDE UTIL TOOL ***"

echo "*** CHOOSE WHAT YOU WANT TO DO (check/update/both), CAREFUL : CASE SENSITIVE ***"
read choice

function check {
	echo "*** CONFIGURATION CHECK ***"
	sudo aide -c /etc/aide/aide.conf --config-check
	echo "*** CONFIGURATION CHECK OVER ***"
	
	echo "*** INTEGRITY CHECK ***"
	sudo aide -c /etc/aide/aide.conf --check
	echo "*** INTEGRITY CHECK OVER ***"
}

function update {
	echo "*** UPDATING THE DATABASE ***"
	sudo aide -c /etc/aide/aide.conf --update
	echo "*** UPDATE OVER ***"
}

case $choice in
	check)
		check
		;;
	update)
		update
		;;
	both)
		check
		update
		;;
	*)
		echo "*** ERROR WRONG TYPING ***"
		;;
esac

