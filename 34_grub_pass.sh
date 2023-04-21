#!/bin/bash

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
