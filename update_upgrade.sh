#!/bin/bash

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
