![](pictures/Debian_11_secure/debian_secure_title.png)

> **Information**
> 
> This documentation has been written in <u>Markdown</u> with <u>Mark Text</u> and exported in PDF & HTML.

# Release table

| Date       | Version | Author         | Description                                                                                                                                                                                                                    |
| ---------- | ------- | -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 2022-01-21 | 0.1     | Charles Vissol | First Draft                                                                                                                                                                                                                    |
| 2022-01-25 | 0.2     | Charles Vissol | Integration of ANSSI recommendations<br>Integration of Technical Documentation Master SLED 15 SP2                                                                                                                              |
| 2022-02-01 | 0.9     | Charles Vissol | Add specific chapter about Anonymity & privacy on the internet                                                                                                                                                                 |
| 2022-03-05 | 1.0     | Charles Vissol | §Supported file systems<br>§Protect against remote attackers<br>§Force local-only privileged account<br>§Automatic per-user temporary directories<br>§Restrict mode creation mask<br>§Secure important files<br>§AIDE          |
| 2022-03-09 | 1.1     | Charles Vissol | §configure firefox update                                                                                                                                                                                                      |
| 2022-04-05 | 1.2     | Charles Vissol | Deleted §check for package bugs<br>Modified §Secure important files<br>Added §Stacer<br>Modified §Instant Messaging<br>Add §Desktop environement configuration<br>Add §System information<br>Add §Enable KDE Wallet management |
| 2022-04-15 | 1.3     | Charles Vissol | Add §Update the Encryption passphrase of LUKS                                                                                                                                                                                  |
| 2022-04-15 | 1.4     | Charles Vissol | Update $Add user to sudoers<br>Other modifications (auditd, su program, KDE Wallet...)                                                                                                                                         |

# Introduction

Linux has certain advantages over Windows when it comes to security. These include the following:

- Unlike Windows, Linux was designed from the ground 
  up as a multiuser operating system. So, user security tends to be a bit 
  better on a Linux system.
- Linux offers a better separation between administrative users and unprivileged users. This makes it a bit harder for intruders, and it also makes it a bit harder for a user to accidentally infect a Linux machine with something nasty.
- Linux is much more resistant to viruses and malware infections than Windows is. Certain Linux distributions come with built-in mechanisms, such as SELinux in Red Hat and CentOS, and AppArmor in Debian and Ubuntu, that prevent intruders from taking control of a system.
- Linux is a free and open source software. This allows anyone who has the skill to audit Linux code to hunt for bugs or backdoors.

But even with those advantages, Linux is just like everything else: not perfect.

# Choosing the source of installation

Debian is delivered in 3 options:

- Netinstall images: light images containing the default system with the debian-installer. The additional softwares will be downloaded by the network. In this case, you choose the Desktop environment during the installation. Link here: https://cdimage.debian.org/debian-cd/current/multi-arch/iso-cd/
- complete images that doesn't require any network connection. Link here: https://cdimage.debian.org/debian-cd/current/amd64/iso-dvd/. In most cases dvd-1 is sufficient.
- Live images: autonomous images like complete images. You can boot directly on the ISO image to test first Debian. However, these images are made for a particular Dekstop environment. You must choose it before downloading the image (Gnome, KDE, xfce...). Link here: https://cdimage.debian.org/cdimage/release/current-live/amd64/iso-hybrid/

> **Tips**
> 
> The live images require the installation of additional non free firmware for example to enable Wifi capabilities. If you need a Debian with non free firmware integrated, choose https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/11.2.0-live+nonfree/amd64/iso-hybrid/. In this case, install the distribution with a wired connection to be able to download the necessary resources.

> **Warning**
> 
> *The post-installation requires admin rights*

This documentation uses the Live image of Debian for KDE Desktop environment with non free drivers because it is oriented Laptop and Desktop environment.

# Minimal hardware performance

- 2 GHz dual core processor
- 4 GiB RAM (system memory)

> **Warning**
> 
> For development PC using VirtualBox prefer 16GiB (2x8GiB RAM)

- 25 GB of hard drive space (or USB stick, memory card or external drive but see LiveCD for an alternative approach)
- VGA capable of 1024x768 screen resolution
- Either a CD/DVD drive or a USB port for the installer media
- Internet access must be enabled during installation if you want to update your system. Using laptop, you can configure Wifi card and use it directly.

> **Tips**
> 
> The Wifi configuration for HP PCs is for:
> 
> - EliteBook: Intel Corporation Wireless 7265
> - Zbook 17: Intel Corporation Wireless 8260
> 
> Debian drivers are available for these PCs.

# Notes about hardening

In this documentation, we try to ease the hardening of the system with hardening tools but that doesn't eliminate the need of a good administration during the exploitation of the system. 

Some basics to remind:

- Maintain a regular backup of your data
- Keep system up-to-date
- Regularly remove unnecessary packages
- Keep track of open ports
- In some cases, encrypt your hard disk or your partitions

*Some of the most critical security settings reside within the BIOS of your system. Therefore, non-administrative users should not be allowed to mess with these settings. To prevent this from happening, you must secure your BIOS with a password.*

# Notes about Debian security model

- Debian problems are always handled openly, even security related. Security issues are discussed openly on the debian-security mailing list. Debian Security Advisories (DSAs) are sent to public mailing lists (both internal and external) and are published on the public server. 
- Debian follows security issues closely. The security team checks many security related sources, the most important being http://www.securityfocus.com/cgi-bin/vulns.pl,
- Security updates are the first priority. When a security problem arises in a Debian package, the security update is prepared as fast as possible and distributed for our stable, testing and unstable releases, including all architectures.
- Information regarding security is centralized in a single point, http://security.debian.org/.
- Debian provides a number of useful security related tools for system administration and monitoring. 
- Package maintainers are aware of security issues. This leads to many "secure by default" service installations which could impose certain restrictions on their normal use. Debian does, however, try to balance security and ease of administration - the programs are not de-activated when you install them. In any case, prominent security issues (such as `setuid` programs) are part of the http://www.debian.org/doc/debian-policy/.

# BIOS access restrictions

Set an administrator password to access to the BIOS to protect it in `Security` section by clicking on `Setup BIOS Administrator Password`.

# Enable virtualization

For ZBook PCs, in `Advanced` > `System Options`, select:

- `Virtualization Technology (VTx)`
- `Virtualization Technology for directed I/O (VTd)`

For EliteBook G1 & G2 PCs, in `Advanced` > `Device Configurations`, select:

- `Virtualization Technology (VTx)`
- `Virtualization Technology for directed I/O (VTd)`

# Secure boot

For compliant PCs we enable the Secure boot when it is possible (depending on the PCs). At this point ZBook 17 G3 and EliteBook G3 minimum. 

## History

Historically, BIOS (Basic Input Output System) was responsible for locating boot devices and trying them in a configurable order. Linux usually used a MBR (Master Boot Record) such as LILO or GRUB to check there own settings and boot a Linux kernel.

Things changed when Windows 8 came in the market and introduced the UEFI (Unified Extensible Firmware Interface) technology to replace the traditional BIOS:

- enabling the boot for ARM architecture
- coming with many more features and with recommended or required settings, for example ESP (EFI System Partition) partition mounted on `/boot/efi` which make it possible to exchange data between UEFI-level implementation and installed system

> **Information**
> 
> **Unified Extensible Firmware Interface** (**UEFI**) is a publicly available specification that defines a software interface between an operating system and platform firmware. UEFI replaces the BIOS.
> 
> ![](pictures/Debian_11_secure/UEFI.png)
> 
> The latest UEFI specification was published in March 2021: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_9_2021_03_18.pdf

Comparing to BIOS, UEFI does not rely on boot sectors: it depends on a boot manager implemented at the firmware level, which can be configured from the operating system.

Booting a Linux kernel with UEFI instead of Legacy BIOS usually leads to some extra information getting exposed through `/sys/firmware/efi` directory. In particular, the `efivars.ko` module makes it possible to access variables that are stored in NVRAM (Non Volatile Random-Access Memory).

## What is Secure Boot?

UEFI **Secure** **boot** is a verification mechanism for ensuring that code launched by firmware is trusted it ensures that a device boots using only the software that is trusted by the Original Equipment Manufacturer (signed by acceptable digital signature).

Secure boot has 2 states:

- "Setup" Mode: allows public key (platform key) to be written to the firmware. At this step, Secure boot is disable.
- "User" Mode: once key is written, Secure boot is enabled. At this step, only UEFI drivers and OS boot loaders signed with the platform key can be loaded vy the firmware.

Debian supports Secure boot since Debian 10. You can get the Secure boot state with the following command:

```bash
mokutil --sb-state
```

If Secure boot is enabled, the output is:

```bash
SecureBoot enabled
```

If you want some information about ESP, tip command to get the partitions sequence of booting process:

```bash
efibootmgr -v
```

## ZBook 17 G3

To enable Secure boot you need first to configure the BIOS:

- In `Advanced` > `Secure Boot Configuration`:
  - Select `Enable MS UEFI CA key`
  - Select `Reset Secure Boot keys to factory defaults`

Save the changes

- In `Advanced` > `Option ROM Launch Policy`, select `All UEFI`

Save all changes and exit.

Once you exit from the BIOS and reboot the PC.

See full PK, KEK, DB and DBX in Annex.

## EliteBook G1 and G2

G1 and G2 doesn't support with Debian system, the SecureBoot. Specifically for these laptops, we modified the BIOS configuration:

- In `Advanced` > `Boot Options`, uncheck:
  
  - `SecureBoot`
  
  - `Clear SecureBoot Keys`

- Check `Customized Boot`
  
  Choose:
  
  - `UEFI Native (Without CSM)`

> **Information**
> 
> CSM is Compatibility Support Module to provide legacy BIOS compatibility. Without CSM, we avoid legacy-BIOS based systems or BIOS-MBR (BIOS-style booting from MBR-partitioned disks) systems

After the first installation of the system, we add rEFInd Boot Manager, developed by Roderick W. Smith employed by Canonical  who is a Linux expert. He delivers a DEB package that fits to Debian and allows to control the Boot menu and offers several options to boot and a complete configuration file in:

 `/boot/efi/EFI/refind/refind.conf` (folder accessible only to root).

The main purpose of rEFInd is not to replace boot loaders. It is not a boot loader. The main purpose of rEFInd is to provide more control on boot loaders and avoid using CSM/legacy mode.

Project available here: https://www.rodsbooks.com/refind/ and official Debian reference at [Debian -- Details of package refind in bullseye](https://packages.debian.org/bullseye/refind).

Proceed to the installation:

```bash
sudo apt install refind
```

Due to the fact that if the `sbsigntool` (package which signs cryptographically EFI binaries and drivers) package is installed, the  installation scripts will generate and use **their own Secure Boot keys**  and sign the binary with them.

Startup menu in EliteBook G1 and G2:

<img src="./pictures/Debian_11_secure/refind.jpg" style="width:100%"/>

## Elitebook G3

Elitebook G3 allows you to enable SecureBoot.

To prepare the SecureBoot, configure the BIOS like this:

- In `Advanced` > `Secure Boot Configuration`:
  
  - Select `Enable MS UEFI CA key`
  
  - Select `Reset Secure Boot keys to factory defaults`

You must previously select in the list to enable SecureBoot (in French "Desactivation de la prise en charge du mode propriétaire et activation du démarrage sécurisé").

# Resources

1. **Distro & version selection**

We select a live image of Debian with the pre-installed KDE Desktop environment: `debian-live-11.2.0-amd64-kde+nonfree.iso`.

Verification of the ISO image (compare with SHA512SUMS)

```bash
echo "20fa1c5c7d4c6e6d258380879d8bd89b17613181b68c7f39ee973486642ddb01c097b1ef2b1cdaac7bf42474754c3c44718bba2bb7baed272d3896e9287a672c  debian-live-11.2.0-amd64-kde+nonfree.iso" | shasum -a 512 --check
```

Result must be:

```bash
debian-live-11.2.0-amd64-kde+nonfree.iso: OK
```

Another way could be to use` md5sum`:

```bash
md5sum debian-live-11.2.0-amd64-kde+nonfree.iso
```

To display:

```bash
20fa1c5c7d4c6e6d258380879d8bd89b17613181b68c7f39ee973486642ddb01c097b1ef2b1cdaac7bf42474754c3c44718bba2bb7baed272d3896e9287a672c  debian-live-11.2.0-amd64-kde+nonfree.iso
```

You can compare the result with the SHA512SUMS file content.

# Standard installation

> **Information**
> 
> The standard installation takes into account partitioning (/home, /var, /tmp) with LVM (Logical Volume Manager) but optionally encryption (not by default).
> 
> We assume that you will create 2 accounts: a root account and a user account with different passwords. This is a secure basic principle. 
> 
> Later you can add user account to sudoers.
> 
> Due to Wifi embedded drivers, you configure Wifi during installation.

- Choose installation mode: Select Graphical Debian Installer

![](./pictures/Debian_11_secure/Start_menu_install.png)

- Choose language: here English and click Continue

![](./pictures/Debian_11_secure/select_language.png)

- Select location: other, Europe and France or... recommanded Andorra (other location for privacy), click Continue

![](./pictures/Debian_11_secure/select_location.png)

- Configure locales: choose en_US.UTF-8 and click Continue

![](./pictures/Debian_11_secure/select_locale.png)

- Configure keyboard: Choose French and click Continue

![](./pictures/Debian_11_secure/configure_keyboard.png)

- Configure Wifi connection: 
  
  - Select the Wifi card
  
  <img src="pictures/Debian_11_secure/wifi1.png" style="zoom:60%;" />
  
  - Select the box
  
  <img src="pictures/Debian_11_secure/wifi2.png" style="zoom:60%;" />
  
  - Select the network configuration
  
  <img src="pictures/Debian_11_secure/wifi3.png" style="zoom:60%;" />
  
  - Tip the credentials

- Configure the network: tip the hostname of your system

![](./pictures/Debian_11_secure/set_hostname.png)

- Configure the network: tip the domain name and click Continue

![](./pictures/Debian_11_secure/set_domain.png)

- Set the root password and click Continue

> **Tips** 
> 
> *Use a complex Password. See [Strongpasswordgenerator.com](https://strongpasswordgenerator.com/) if necessary*

![](./pictures/Debian_11_secure/root_pwd.png)

- Set a non-root username account and click Continue

![](./pictures/Debian_11_secure/set_user_name.png)

- Set user password and click Continue

![](./pictures/Debian_11_secure/Set_user_pwd.png)

- Partition disks: use option `Guided - use entire disk and set up LVM` or `Guided - use entire disk and set up encrypted LVM` if you want a better security. Click Continue

![](pictures/Debian_11_secure/setup_lvm.png)

> **Tips**
> 
> If you choose to not encrypt the disk, you can later install `cryptsetup` to encrypt data on a removable media

- Select hard drive where you install the Debian and click Continue
- Choose Separate `/home`, `/var` and `/tmp` partitions and click Continue

![](./pictures/Debian_11_secure/partitions.png)

> **Warning**
> 
> The drawbacks of partitions is that `/var` partition is about 10GB size and it requires frequent cleaning. If this space is full, Debian do not load Desktop environment: you need to start in recovery mode and clean `/var`.

- Choose "Yes" and click Continue

![](./pictures/Debian_11_secure/partition-write.png)

![](./pictures/Debian_11_secure/write-on-disk.png)

- Confirm and click on continue

![](./pictures/Debian_11_secure/disk_encryption.png)

- click Continue

![](./pictures/Debian_11_secure/disk-partition.png)

- Choose Yes & Click Continue

- Choose "Finish partitioning and write changes to disk" and click Continue

![](./pictures/Debian_11_secure/finish-encryption.png)

- Choose "Yes" and click Continue

![](./pictures/Debian_11_secure/confirm-encryption.png)

- Configure package manager: choose "Yes", click Continue

>  **Warning**
> 
> At this level you need a network access to the internet

![](./pictures/Debian_11_secure/choose-package-manager.png)

- Choose "France", click Continue
- Select "deb.debian.org", click Continue

![](./pictures/Debian_11_secure/repository.png)

- Configure proxy (here none), click Continue

![](./pictures/Debian_11_secure/proxy.png)

![](./pictures/Debian_11_secure/scanning-mirrors.png)

![](./pictures/Debian_11_secure/grub-install.png)

- Choose "Yes" and click Continue

![](./pictures/Debian_11_secure/conf-grub.png)

- Choose the device where installing Grub, click Continue
- After this last step, installation is complete. Click Continue

![](./pictures/Debian_11_secure/install-complete.png)

Debian finishes the installation...

![](./pictures/Debian_11_secure/finishes-install.png)

Debian Reboot, using GRUB and display the login form:

![](./pictures/Debian_11_secure/first-login.png)

Tip the first user account password and join the KDE environment.

# Software updates & upgrades

Updates of Debian, like any other Open Source software, are made to fix quickly security issues when they are detected. So it is mostly important to take your system up-to-date.

To update the full system in one time you can, in root mode, run the command:

```bash
apt update && apt upgrade -y
```

In sudoer mode, run:

```bash
sudo apt update && apt upgrade -y
```

`update` command reloads package list information locally.

![](./pictures/Debian_11_secure/first-apt-update.png)

`full-upgrade` command update the system by adding or removing packages if necessary.

However, the update process is something automatic in Debian and you will be constantly notified by new updates in the Debian task bar:![](./pictures/Debian_11_secure/updates_notif.png)

Once you receive the notification, click on the icon or open directly Discover, the Software Center of KDE then Click on "Fetching updates..." and proceed to updates if necessary. At the end, you must be up-to-date:

![](./pictures/Debian_11_secure/updates.png)

If you want to check manually for available updates, run simply (here sudoer command):

```bash
sudo apt update
```

# Security

This part doesn't cover the BIOS security (i.e. BIOS password, etc.)

## Good to know about Debian security...

- Debian problems are always handled openly, even security related.  Security issues are discussed openly on the debian-security mailing  list. Debian Security Advisories (DSAs) are sent to public mailing lists (both internal and external) and are published on the public server.
- Debian follows security issues closely. The security team checks many security related sources, the most important being http://www.securityfocus.com/cgi-bin/vulns.pl, on the lookout for packages with security issues that might be included in Debian.
- Security updates are the first priority. When a security problem  arises in a Debian package, the security update is prepared as fast as  possible and distributed for our stable, testing and unstable releases,  including all architectures.
- Information regarding security is centralized in a single point, https://security.debian.org/.
- Debian is always trying to improve the overall security of the  distribution by starting new projects, such as automatic package  signature verification mechanisms.
- Debian provides a number of useful security related tools for  system administration and monitoring. Developers try to tightly  integrate these tools with the distribution in order to make them a  better suite to enforce local security policies. Tools include:  integrity checkers, auditing tools, hardening tools, firewall tools,  intrusion detection tools, etc. 
- Package maintainers are aware of security issues. This leads to  many "secure by default" service installations which could impose  certain restrictions on their normal use. 

To summarize, you must consult the https://security.debian.org/ regularly to be aware of the last security & updates. 

You must also add the security repository to `/etc/apt/sources.list` with the following line:

```bash
deb http://security.debian.org/debian-security bullseye-security main contrib non-free
```

Then execute 

```bash
apt-get update && apt-get upgrade
```

to download and apply pending updates. 

The security archive is signed.

## Find bugs

Connect to https://udd.debian.org/bugs/ for detailed bugs.

If you want to always know the bugs status of a package you want to install, install `apt-listbugs` (See chapter "Check for packages bugs").

## Setup automatic updates & upgrades (optional)

Here we setup the official Debian method to automate the upgrades.

1. Install `unattended-upgrades` if not already installed (normally it is the case):

```bash
sudo apt install unattended-upgrades
```

2. Edit the `50unattended-upgrades` located in `/etc/apt/apt.conf.d`
   
   2.1. Uncomment the following lines:

```bash
"origin=Debian,codename=${distro_codename}-updates";
"origin=Debian,codename=${distro_codename}-proposed-updates";
"origin=Debian,codename=${distro_codename},label=Debian";
"origin=Debian,codename=${distro_codename},label=Debian-Security";
```

> **Tips**
> 
> Note that if you want to be notified by Email, you must uncomment the line `Unattended-Upgrade::Mail` and specify the Email address where you want to receive the notifications.

Ex: `Unattended-Upgrade::Mail "mr.admin@superbusiness.com";`

​        2.2. Uncomment the following line to force the update in case of an unclean `dpkg` exit

```bash
Unattended-Upgrade::AutoFixInterruptedDpkg "true";
```

​        2.3. Uncomment the following line to remove automatically unused dependencies from the system and set to `true`.

```bash
Unattended-Upgrade::Remove-Unused-Dependencies "true";
```

​        2.4. Save the file

3. enable `unattended-upgrades` with the command bellow

```bash
sudo dpkg-reconfigure --priority=low unattended-upgrades
```

This command makes the following window appears: select `<Yes>`

![](pictures/Debian_11_secure/unattended-upgrade1.png)

The process updates `/etc/apt/apt.conf.d/20auto-upgrades` file adding the following content:

```bash
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
```

You can check if `unattended-upgrades` is running:

```bash
sudo systemctl status unattended-upgrades.service
```

The result should be something like that:

```bash
● unattended-upgrades.service - Unattended Upgrades Shutdown
   Loaded: loaded (/lib/systemd/system/unattended-upgrades.service; enabled; vendor preset: enabled)
   Active: active (running) since Sat 2021-12-11 14:48:04 CET; 1 months 9 days ago
     Docs: man:unattended-upgrade(8)
 Main PID: 770 (unattended-upgr)
    Tasks: 2 (limit: 4915)
   Memory: 19.2M
   CGroup: /system.slice/unattended-upgrades.service
           └─770 /usr/bin/python3 /usr/share/unattended-upgrades/unattended-upgrade-shutdown --wait-for-signal
```

> **Information**
> 
> the Log file is in `/var/log/unattended-upgrades` directory

If you want to uninstall the auto-upgrade tip:

```bash
sudo dpkg-reconfigure --priority=low unattended-upgrades
```

And select `<No>`

![](pictures/Debian_11_secure/unattended-upgrade2.png)

## Passwords

Choosing the right password is first strategy to ensure a good security of your system. User passwords can sometimes become the *weakest link* in the security of a given system. This is due to some users choosing weak passwords for their accounts.

Since user access might include remote shell access it's important to make password guessing as hard as possible for the remote attackers, especially if they were somehow able to  collect important information such as usernames or even the `passwd` and `shadow` files themselves.

Debian Security Guide recommends 2 websites to describe basic rules for password:

- [Eric Wolfram's site](http://wolfram.org/writing/howto/password.html)
- [Walter Belger's site](http://www.belgers.com/write/pwseceng.txt)

Fortunately, Debian proposes a set of password generating programs:

- `makepasswd` : generates true random passwords with an emphasis on security over pronounceability
- `pwgen`: generate true random password with emphasis on security over meaningless but pronounceable password
- `apg`: provides both security aspects: meaningless & pronounceability

You can install `makepasswd` by running:

```bash
sudo apt-get install makepasswd
```

You can install `pwgen` by running:

```bash
sudo apt-get install pwgen
```

You can install `apg` by running:

```bash
sudo apt-get install apg
```

Use these programs to generate passwords.

`Passwd` does not allow non-interactive  assignation of passwords (since it uses direct tty access). If you want  to change passwords when creating a large number of users you can create them using `adduser` with the `--disabled-login` option and then use `usermod` or `chpasswd` ([See Securing Debian Manual](https://www.debian.org/doc/manuals/securing-debian-manual/ch04s11.en.html#ftn.id-1.5.14.21.3.6))  . Both are from the **passwd** package so you already have them installed. If you want to use a file with all the information to make users as a batch process you might be better off using `newusers`.    

## Secure cron

> **SH**
> 
> Execute `1_secure_cron.sh`

- Secure `/etc/crontab` by typing:

```bash
chown root:root /etc/crontab
chmod og-rwx /etc/crontab
```

- Secure `/etc/cron.hourly` by typing:

```bash
chown root:root /etc/cron.hourly
chmod og-rwx /etc/cron.hourly
```

- Secure `/etc/cron.daily` by typing:

```bash
chown root:root /etc/cron.daily
chmod og-rwx /etc/cron.daily
```

- Secure `/etc/cron.weekly` by typing:

```bash
chown root:root /etc/cron.weekly
chmod og-rwx /etc/cron.weekly
```

- Secure `/etc/cron.monthly` by typing:

```bash
chown root:root /etc/cron.monthly
chmod og-rwx /etc/cron.monthly
```

- Secure `/etc/cron.d` by typing:

```bash
chown root:root /etc/cron.d
chmod og-rwx /etc/cron.d
```

- Restrict CRON access:

```bash
touch /etc/cron.allow
touch /etc/cron.deny
chmod og-rwx /etc/cron.allow
chmod og-rwx /etc/cron.deny
```

## AppArmor

AppArmor is installed by default on Debian OS and active.

Example of AppArmor status:

```bash
# sudo aa-status
apparmor module is loaded.
40 profiles are loaded.
30 profiles are in enforce mode.
   /snap/core/12603/usr/lib/snapd/snap-confine
   /snap/core/12603/usr/lib/snapd/snap-confine//mount-namespace-capture-helper
   /usr/bin/akonadiserver
   /usr/bin/freshclam
   /usr/bin/i2prouter//sanitized_helper
   /usr/bin/man
   /usr/lib/cups/backend/cups-pdf
   /usr/lib/snapd/snap-confine
   /usr/lib/snapd/snap-confine//mount-namespace-capture-helper
   /usr/sbin/cups-browsed
   /usr/sbin/cupsd
   /usr/sbin/cupsd//third_party
   /usr/sbin/haveged
   firejail-default
   libreoffice-senddoc
   libreoffice-soffice//gpg
   libreoffice-xpdfimport
   lsb_release
   man_filter
   man_groff
   mariadbd_akonadi
   mysqld_akonadi
   nvidia_modprobe
   nvidia_modprobe//kmod
   postgresql_akonadi
   snap-update-ns.code
   snap-update-ns.core
   snap-update-ns.pycharm-community
   snap.core.hook.configure
   system_i2p//sanitized_helper
10 profiles are in complain mode.
   /usr/bin/i2prouter
   /usr/libexec/ibus-engine-hangul
   /usr/libexec/ibus-setup-hangul
   /usr/libexec/ibus-setup-hangul//python_profile
   libreoffice-oosplash
   libreoffice-soffice
   snap.code.code
   snap.code.url-handler
   snap.pycharm-community.pycharm-community
   system_i2p
0 profiles are in kill mode.
0 profiles are in unconfined mode.
5 processes have profiles defined.
5 processes are in enforce mode.
   /usr/bin/akonadiserver (4860) 
   /usr/bin/freshclam (1757) 
   /usr/sbin/cups-browsed (1759) 
   /usr/sbin/cupsd (1275) 
   /usr/sbin/haveged (840) 
0 processes are in complain mode.
0 processes are unconfined but have a profile defined.
0 processes are in mixed mode.
0 processes are in kill mode.
```

AppArmor is a *Mandatory Access Control* (MAC) system built on Linux's LSM (*Linux Security Modules*) interface. In practice, the kernel queries AppArmor before each system call to know whether the process is authorized to do the given operation. Through this mechanism, AppArmor confines programs to a limited set of resources.

AppArmor applies a set of rules (known as “profile”) on each program. The profile applied by the kernel depends on the installation path of the program being executed. Contrary to SELinux, the rules applied do not depend on the user. All users face the same set of rules when they are executing the same program (but traditional user permissions still apply and might result in different behavior...).

## Perl module

Perl module is installed by default. We decided not to uninstall this module due to its dependencies with a long serie of utilities.

## Verify listening services

In a default Debian standard installation you will end up with OpenSSH, Exim (depending on how you configured it) and the RPC portmapper available as network services (NFS for example).

In our case, there is no RPC portmapper services running, no OpenSSH but an Exim service.

To check the running services, the best way is to install `net-tools` to check, after installation, but also during all the usage of the PC that any user avoid installing dangerous services for PCs in contact with the internet such as:

- NFS (Network File Sytem) to share file systems across network
- rpc.* services: Remote Procedure Call, typically NFS and NIS related
- Printer services (lpd)
- r* services (r for "remote"): rsh, rlogin, rexec, rcp etc.
- telnet server
- ftp server
- DNS server package
- MTA (Mail Transport Agent), such as sendmail, exim, postfix, qmail

Install it by running:

```bash
sudo apt-get install net-tools
```

Once installed, you can run the following commands:

```bash
netstat -tap | grep LISTEN
```

Result:

```bash
tcp        0      0 localhost:ipp           0.0.0.0:*               LISTEN      875/cupsd           
tcp        0      0 localhost:smtp          0.0.0.0:*               LISTEN      1290/exim4          
tcp6       0      0 [::]:1716               [::]:*                  LISTEN      1629/kdeconnectd    
tcp6       0      0 localhost:ipp           [::]:*                  LISTEN      875/cupsd           
tcp6       0      0 localhost:smtp          [::]:*                  LISTEN 
```

## Enforce password policy

> **Information**
> 
> In the following chapters we will use `libpam` libraries which are part of Pluggable Authentication Module.
> 
> All the configuration files are in `/etc/security`.

- install module `libpam-pwquality`

```bash
sudo apt install libpam-pwquality
```

- Edit the `/etc/pam.d/common-password`
- Comment the line `password     required    pam_permit.so` with `#` at the beginning of the line

```bash
#password required pam_permit.so
```

- At the line of `pam_unix.so` add `remember=5`:

```bash
password        [success=1 default=ignore]      pam_unix.so remember=5 obscure yescrypt
```

- Add the following line at the end of the file: 

```bash
password requisite pam_pwquality.so minlen=14 retry=3 dcredit=-1 lcredit=-1 ocredit=-1 ucredit=-1 reject_username
```

- Save file

- Modify your password (command `passwd`) with the new rules

> Password are stored in `/etc/shadow` file

- Edit `/etc/login.defs`
- `UMASK` value is turned from `022` to `027` (files created by user or group visible only by this user or group)
- Modify `PASS_MAX_DAY`: set `90` instead of `99999`
- Modify `PASS_MIN_DAY`: set `7` instead of `0`
- Modify `PASS_WARN_AGE`: set `10` instead of `7`
- Uncomment `SHA_CRYPT_MIN_ROUNDS` and set `65536` value (`ENCRYPT_METHOD` is already `SHA512`)

By default, the login process allows by default 5 times error and after forces the user to wait 60 seconds.

## Protect against remote attackers

install module `libpam-shield`

```bash
sudo apt install libpam-shield
```

The default configuration protect sufficiently against remote access.

## Force local-only privileged accounts

Edit `/etc/security/access.conf` and uncomment:

```bash
-:wheel:ALL EXCEPT LOCAL .win.tue.nl
```

## Automatic per-user temporary directories

Many programs use `$TMPDIR` for storing temporary files. 
Not all of them are good at securing the permissions of those files. `libpam-tmpdir` sets `$TMPDIR` and `$TMP` for PAM sessions and sets the permissions quite tight. 
This helps system security by having an extra layer of security, making such symlink attacks and other /tmp based attacks harder or impossible automatic per-user temporary directories.

Tip:

```bash
apt install libpam-tmpdir
```

## Restrict mode creation mask

Edit `/etc/profile` and `/etc/bash.bashrc` and add at the beginning of these files:

```bash
umask 027
```

## Secure important files

> We do not apply `chmod 000 /etc/shadow` because of its side-effect on Unlock the Desktop session: it engender a systematic logging error.

- Secure `/etc/gshadow`, tip:

```bash
chmod 000 /etc/gshadow
```

- Secure `/etc/passwd-`, tip:

```bash
chmod 000 /etc/passwd-
```

- Secure `/etc/group-`, tip:

```bash
chmod 000 /etc/group-
```

## Partition configuration (ANSSI recommendation)

- edit `/etc/fstab`
- Add the following parameters:

```bash
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
/dev/mapper/debian--dev--vg-root /               ext4    errors=remount-ro 0       1
# /boot was on /dev/sda2 during installation
UUID=102cf72b-cfbd-4a29-858d-d8297d3767fb /boot           ext2    nosuid,nodev,noexec        0       2
# /boot/efi was on /dev/sda1 during installation
UUID=E708-28B1  /boot/efi       vfat    umask=0077      0       1
/dev/mapper/debian--dev--vg-home /home           ext4    nodev        0       2
/dev/mapper/debian--dev--vg-tmp /tmp            ext4    nosuid,nodev,noexec        0       2
/dev/mapper/debian--dev--vg-var /var            ext4    nosuid,nodev        0       2
/dev/mapper/debian--dev--vg-swap_1 none            swap    sw              0       0
/dev/sr0        /media/cdrom0   udf,iso9660 user,noauto     0       0
tmpfs /dev/shm  tmpfs   rw,noexec,nosuid,nodev  0       0
```

- `nosuid` option ignore `setuid`/`setgid`
- `nodev` option ignore character devices or random device hardware
- `noexec` option ignore execution rights

>  **Tips**
> 
> `/home` (`nosuid`, `noexec`) ANSSI recommendation is partially at `/home` directory we want the executable to be executed in the owner context only.

> **Warning**
> 
> We choose to not apply `noexec` to `/var` despite the ANSSI recommandations because the standard `APT` process execute `dpkg` to deploy properly standard debian packages.
> 
> We also add `tmpfs` configuration to secure the share memory (share data between processes)

## Modifying kernel parameters (ANSSI recommendation)

Here, the ANSSI recommendations are not up-to-date. However, we apply all the ANSSI rules when they exist in Debian 11.

- `kernel.domainname`: unmodified because declaration in `/etc/hostname` for Debian

In `/etc/sysctl.conf` uncomment:

- `net.ipv4.conf.default.rp_filter=1`
- `net.ipv4.conf.all.rp_filter=1`
- `net.ipv4.tcp_syncookies=1`
- `net.ipv4.conf.all.accept_redirects = 0`
- `net.ipv6.conf.all.accept_redirects = 0`
- `net.ipv4.conf.all.send_redirects = 0`
- `net.ipv4.conf.all.log_martians = 1` Not in ANSSI documentation, but we choose to log Martian packets

Uncomment and turned to 0:

- `net.ipv4.ip_forward=0`
- `net.ipv4.conf.all.secure_redirects = 0`

```bash
#
# /etc/sysctl.conf - Configuration file for setting system variables
# See /etc/sysctl.d/ for additional system variables.
# See sysctl.conf (5) for information.
#

#kernel.domainname = example.com

# Uncomment the following to stop low-level messages on console
#kernel.printk = 3 4 1 3

###################################################################
# Functions previously found in netbase
#

# Uncomment the next two lines to enable Spoof protection (reverse-path filter)
# Turn on Source Address Verification in all interfaces to
# prevent some spoofing attacks
net.ipv4.conf.default.rp_filter=1
net.ipv4.conf.all.rp_filter=1

# Uncomment the next line to enable TCP/IP SYN cookies
# See http://lwn.net/Articles/277146/
# Note: This may impact IPv6 TCP sessions too
net.ipv4.tcp_syncookies=1

# Uncomment the next line to enable packet forwarding for IPv4
net.ipv4.ip_forward=0

# Uncomment the next line to enable packet forwarding for IPv6
#  Enabling this option disables Stateless Address Autoconfiguration
#  based on Router Advertisements for this host
#net.ipv6.conf.all.forwarding=1


###################################################################
# Additional settings - these settings can improve the network
# security of the host and prevent against some network attacks
# including spoofing attacks and man in the middle attacks through
# redirection. Some network environments, however, require that these
# settings are disabled so review and enable them as needed.
#
# Do not accept ICMP redirects (prevent MITM attacks)
net.ipv4.conf.all.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
# _or_
# Accept ICMP redirects only for gateways listed in our default
# gateway list (enabled by default)
net.ipv4.conf.all.secure_redirects = 0
#
# Do not send ICMP redirects (we are not a router)
net.ipv4.conf.all.send_redirects = 0
#
# Do not accept IP source route packets (we are not a router)
net.ipv4.conf.all.accept_source_route = 0
net.ipv6.conf.all.accept_source_route = 0
#
# Log Martian Packets
net.ipv4.conf.all.log_martians = 1
#

###################################################################
# Magic system request Key
# 0=disable, 1=enable all, >1 bitmask of sysrq functions
# See https://www.kernel.org/doc/html/latest/admin-guide/sysrq.html
# for what other values do
#kernel.sysrq=438
```

We let the kernel.sysrq disable because `/proc/sys/kernel/sysrq` is 438 value and allows **magic SysRq key** is a key combination. This key combination provides access to powerful features for software development and disaster recovery and we prefer to let this value as is.

## Modifying Kernel parameters

Check `sysctl` parameter using:

```bash
sysctl -a | grep <key_parameter>
```

Example:

```bash
sysctl -a | grep accept_ra
```

To apply new value parameter:

```bash
sysctl -w <parameter>=<value>
```

Example:

```bash
sysctl -w net.ipv6.conf.all.accept_ra=1
```

To apply change:

```bash
sysctl -p
```

The targeted parameters to modify are:

```bash
#Compliant with ArianeGroup SSI referential
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0

net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0


net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0


net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.secure_redirects = 0


net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1

net.ipv4.icmp_echo_ignore_broadcast = 1

net.ipv4.icmp_ignore_bogus_error_responses = 1

#Not compliant with ArianeGroup SSI referential
net.ipv6.conf.all.accept_ra = 1
net.ipv6.conf.default.accept_ra = 1
```

## Enable Auditd (ANSSI recommendation)

In Debian, the package requires an installation:

```bash
apt-get install auditd audispd-plugins
```

- Edit `/etc/audit/rules.d/audit.rules` and add the following rules:

```bash
# insmod Execution, rmmod and modprobe
-w /sbin/insmod -p x
-w /sbin/modprobe -p x
-w /sbin/rmmod -p x
# Audit /etc/ modifications
-w /etc/ -p wa
# Audit mount/Unmount
-a exit,always -F arch=b64 -S mount -S umount2
# Audit syscalls x86 suspects
-a exit,always -F arch=b64 -S ioperm -S modify_ldt
# Audit rare syscalls
-a exit,always -F arch=b64 -S get_kernel_syms -S ptrace
-a exit,always -F arch=b64 -S prctl
# Lock auditd configuration
-e 2
```

>  **Warning**
> 
> We do not integrate audit under files creation/deletion because of its impact on the system performances.

Excluded rules:

```bash
-a exit,always -F arch=b64 -S unlink -S rmdir -S rename
#-a exit,always -F arch=b64 -S creat -S open -S openat -F exit=-EACCESS
#-a exit,always -F arch=b64 -S truncate -S ftruncate -F exit=-EACCESS
```

- [Optional] Create *time-change* rules to make sure events are collected on correct date or time. Create the /etc/audit/rules.d/time.rules file with the rules:

```bash
-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change
-a always,exit -F arch=b64 -S clock_settime -k time-change
-a always,exit -F arch=b32 -S clock_settime -k time-change -w /etc/localtime -p wa -k time-change
```

- Create *system-locale* rules to record changes to network files or system calls. Create the file `/etc/audit/rules.d/system-locale.rules` with the following contents:

```bash
-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale
-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale
-w /etc/issue -p wa -k system-locale
-w /etc/issue.net -p wa -k system-locale
-w /etc/hosts -p wa -k system-locale
-w /etc/network -p wa -k system-locale
```

- [Optional] Create *identity* rules to record user related information, e.g. username, passwords, group. Create the file `/etc/audit/rules.d/identity.rules` with the following contents:

```bash
-w /etc/group -p wa -k identity
-w /etc/passwd -p wa -k identity
-w /etc/gshadow -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/security/opasswd -p wa -k identity
```

- [Optional] Create *login* rules to record login and logout events. Create the file /etc/audit/rules.d/logins.rules with the following contents:

```bash
-w /var/log/faillog -p wa -k logins
-w /var/log/lastlog -p wa -k logins
-w /var/log/tallylog -p wa -k logins
```

- [Optional] Create *permission* mode rules to monitor file attributes, ownership and permission changes. Create the file `/etc/audit/rules.d/permissions.rules` with the following contents:

```bash
-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295
-k perm_mod
-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295
-k perm_mod
```

- Create access mode rules to monitor unauthorized access. Create the file `/etc/audit/rules.d/accesses.rules` with the following contents:

```bash
-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access
-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access
-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access
-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access
```

- Create mount mode rules to monitor mount/unmount event. Create the file `/etc/audit/rules.d/mounts.rules` with the following contents:

```bash
-a always,exit -F arch=b64 -S mount -S umount -F auid>=1000 -F auid!=4294967295 -k mounts
-a always,exit -F arch=b32 -S mount -S umount -F auid>=1000 -F auid!=4294967295 -k mounts 
```

- Create *scope* rules to monitor scope changes particularly the `/etc/sudoers` file. Create the file `/etc/audit/rules.d/scope.rules` with the following contents:

```bash
-w /etc/sudoers -p wa -k scope
-w /etc/sudoers.d/ -p wa -k scope
```

- Create root rule to monitor root events. Create the file `/etc/audit/rules.d/root.rules` with following contents:

```bash
-a exit,always -F arch=b64 -F euid=0 -S execve -k  ROOT_ACTION
-a exit,always -F arch=b32 -F euid=0 -S execve -k  ROOT_ACTION
```

- Enable immutable mode for auditd by adding at the end of the `/etc/audit/rules.d/audit.rules` the `-e 2`

- Configure logs: in `/etc/audit/auditd.conf`, change the following settings:

| Parameter    | Old value | New value | Comment                                                                       |
| ------------ | --------- | --------- | ----------------------------------------------------------------------------- |
| max_log_file | 8         | 20        | We set the max size of the log file from 8MB to 20MB before starting rotation |
| num_logs     | 5         | 10        | We elevate number of rotation logs to 10 files                                |
| log_format   | ENRICHED  | RAW       | ... for lighter logs...                                                       |

- Restart the auditd service: `systemctl restart auditd`

> **Information**
> 
> Auditd documentation in [GitHub - linux-audit/audit-documentation: Documentation and specifications](https://github.com/linux-audit/audit-documentation)

> Logs are available at `/var/log/audit`

> **Tips**
> 
> Use `aureport` and `ausearch` to check auditd information

## Install the Antivirus

- Open Discover and tip clamtk in the search input

![](pictures/Debian_11_secure/clamtk_install1.png)

- Click on Install
- Open ClamTk and click Update Assistant

![](./pictures/Debian_11_secure/clamtk_update.png)

- Click on update Assistant, select "My computer automatically receives updates" and click on Apply and then Back.

![](./pictures/Debian_11_secure/clamtk_update2.png)

- Setting: Click on settings  and check all the categories of scan

![](./pictures/Debian_11_secure/clamtk-settings.png)

- You can schedule regular scan via Scheduler

![](pictures/Debian_11_secure/clamtk_scheduler.png)

- Additionally, because ClamTk does not install Clamav daemon, but only freshclam,

> **Tips**
> 
> To confirm the problem let's check `/var/log/clamav/freshclam.log` and see the line:

```bash
[...] ERROR: NotifyClamd: Can't find or parse configuration file /etc/clamav/clamd.conf
```

you need to run the command:

```bash
sudo apt install clamav-daemon
```

Freshclam works to update automatically the AntiVirus database (daemon here):

```bash
/etc/clamav/freshclam.conf
/var/log/clamav/freshclam.log
```

Clamav-daemon comes with `clamscan` necessary to scan specific files/directories

```bash
/etc/clamav/clamd.conf
/var/log/clamav/clamav.log
```

- Edit `/etc/clamav/clamd.conf`:
  
  - Set `DetectPUA` to `true`
  - Add `OnAccessIncludePath /home/{username}/Downloads
  - Add `OnAccessPrevention yes`

- restart the service

```bash
sudo systemctl restart clamav-daemon
```

> **Tips**
> 
> If you want to scan quickly a directory tip:
> 
> ```bash
> clamscan -r {your-directory}
> ```

> **Tips**
> 
> Graphically, at anytime, you can scan a file or a directory by right-click into Dolphin (file explorer).

## Setup the Firewall

- Open Discover, search gufw and click Install

![](./pictures/Debian_11_secure/firewall-install.png)

- Open the Gufw firewall (requires administrative right)
- Turn on the Gufw firewall. 

> **Tips**
> 
> *When you enable, the default will be set to **Deny** for incoming traffic and **Allow** for outgoing traffic.* 

- Configure the **Office** profile **to accept by default only HTTP and HTTPS flows** but not **SMTP** flows...Rules list not exhaustive...

![](./pictures/Debian_11_secure/firewall-configuration.png)

> **Tips**
> 
> *You can configure your Firewall more accurately depending on your usage especially if the PC is for Code development*

## Backup with Déjà Dup Backup

- Open Discover and Search for Déjà Dup Backup

![](pictures/Debian_11_secure/backup-install.png)

- Click Install

> **Tips**
> 
> You can install Déjà Dup backup with the following command line also:
> 
> ```bash
> apt update && apt install deja-dup
> ```

## Store and backup with cryptsetup

If you want to backup your data on an amovible disk but using it not only for backup, you should consider converting your partition in a LUKS (Linux Unified Key Setup) format.

> **Tips**
> 
> If your installation has been performed with encrypted disk, you already have `cryptsetup`.

- Install `cryptsetup`

```bash
sudo apt-get install cryptsetup
```

- Encrypt your partition. In the following command, we take an example with an USB stick `/dev/sdb1`

```bash
sudo cryptsetup -y -v luksFormat /dev/sdb1
```

Before encrypting the device, ensure that it is unmounted:

```bash
sudo umount /dev/sdb1
```

Result should be like this:

```bash
sudo cryptsetup -y -v luksFormat /dev/sdb1
WARNING: Device /dev/sdb1 already contains a 'iso9660' superblock signature.
WARNING: Device /dev/sdb1 already contains a 'dos' partition signature.

WARNING!
========
This will overwrite data on /dev/sdb1 irrevocably.

Are you sure? (Type 'yes' in capital letters): YES
Enter passphrase for /dev/sdb1: 
Verify passphrase: 
Existing 'iso9660' superblock signature on device /dev/sdb1 will be wiped.
Existing 'dos' partition signature on device /dev/sdb1 will be wiped.
Key slot 0 created.
Command successful.
```

- Create the mapping with the newly created device:

```bash
sudo cryptsetup luksOpen /dev/sdb1 backups
```

`backups` is the name you can choose for the newly created device. Adapt this name depending on your needs.

- Check to confirm that the device is present:

```bash
ls -l /dev/mapper/backups
```

You should have the following output:

```bash
lrwxrwxrwx 1 root root 7 Jan 20 15:19 /dev/mapper/backups -> ../dm-5
```

- Check the status of the mapping:

```bash
sudo cryptsetup -v status backups
```

Output should be something like that:

```bash
/dev/mapper/backups is active.
  type:    LUKS2
  cipher:  aes-xts-plain64
  keysize: 512 bits
  key location: keyring
  device:  /dev/sdb1
  sector size:  512
  offset:  32768 sectors
  size:    29995008 sectors
  mode:    read/write
Command successful.
```

- Dump LUKS headers with the command:

```bash
sudo cryptsetup luksDump /dev/sdb1
```

Output should be:

```bash
LUKS header information
Version:        2
Epoch:          3
Metadata area:  16384 [bytes]
Keyslots area:  16744448 [bytes]
UUID:           e5c65d71-9bcc-4c37-bb4c-c7b7dc0e2134
Label:          (no label)
Subsystem:      (no subsystem)
Flags:          (no flags)

Data segments:
  0: crypt
        offset: 16777216 [bytes]
        length: (whole device)
        cipher: aes-xts-plain64
        sector: 512 [bytes]
[...]    
```

- Write zeroes to `/dev/mapper/backups` encrypted device:

```bash
pv -tpreb /dev/zero | dd of=/dev/mapper/backups bs=128M
```

Previously install the `pv` command `sudo apt-get install pv`. This command allows you to monitor the progress.

```bash
dd: error writing '/dev/mapper/backups': No space left on device=>                          ]
14.3GiB 0:31:17 [7.80MiB/s] [                                 <=>                           ]
0+234337 records in
0+234336 records out
15357444096 bytes (15 GB, 14 GiB) copied, 2025.38 s, 7.6 MB/s
```

- Create filesystem

```bash
sudo mkfs.ext4 /dev/mapper/backups
```

Output:

```bash
mke2fs 1.46.5 (30-Dec-2021)
Creating filesystem with 3749376 4k blocks and 938400 inodes
Filesystem UUID: f99c2e15-7b3d-4dbc-9a45-1f11f4110630
Superblock backups stored on blocks: 
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done   
```

- Mount the new filesystem and confirm the filesystem is visible
  - Create directory

```bash
mkdir /luksbackup
```

- Mount filesystem

```bash
/dev/mapper/backups /luksbackup/
```

- Result:

```bash
# df -H
Filesystem                        Size  Used Avail Use% Mounted on
[...]
/dev/mapper/backups                16G   25k   15G   1% /luksbackup
```

In terms of usage, the encrypted media becomes a partition. 

Illustration in Dolphin for Debian 11/KDE:

![](pictures/Debian_11_secure/Dolphin_encrypted_partition.png)

> **Tips**
> 
> ZBooks have 2 SSD/Sata locations additionally to NVMe/PCI disks. So it is completely possible to use specific encrypted disk without having a full disk encryption.

## Add user to sudoers

`sudo` is a command-line utility that allows trusted users to run commands as another user, by default root. This choice depends on the usage of the Debian. If you share your environment with other privileged users, you must adopt sudoers method to avoid sharing root password. If you use it alone, create a user account without sudoer privileges.

The quickest and easiest way to grant `sudo` privileges to a user is to  add the user to the `sudo` group. Members of this group can execute any  command as root via `sudo` and prompted to authenticate themselves with their password when using `sudo`.

Run the command as **root**:

```bash
sudo visudo
```

> **Information:**
> 
> By default, the account password will be asked every **five minutes** in order to perform sudo operations.

Add after `root ALL=(ALL:ALL) ALL`:

```bash
<username> ALL=(ALL:ALL) ALL
```

If you want to tweak the password verification period, you can add `timestamp_timeout` parameter (in minutes):

```bash
#
# This file MUST be edited with the 'visudo' command as root.
#
# Please consider adding local content in /etc/sudoers.d/ instead of
# directly modifying this file.
#
# See the man page for details on how to write a sudoers file.
#
Defaults        env_reset
Defaults        mail_badpass
Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
Defaults        use_pty
Defaults        timestamp_timeout=30
```

Here password is requested every 30 minutes.

## Deny `su` program to non-admins

- Tip the following command

```bash
sudo dpkg-statoverride --update --add root sudo 4750 /bin/su
#username is the default account of the system
```

> At this point the sudoer can turn to root with the command `sudo su -`

## Secure the /home directory

- Here user is `<username>` but change the name depending on you configuration
  - If you don't share your home folder tip `chmod 0700 /home/<username>`
  - If you share your home folder with a group tip `chmod 0750 /home/<username>`
  - Execute `chmod +t /home/<username>` to enable Sticky bit to `/home` directory

## Secure boot configuration

Tip:

```bash
chmod 600 /boot/grub/grub.cfg
```

## Disable Bluetooth

If your PC has Bluetooth capabilities, uncheck the Bluetooth in KDE Task Manager

![](pictures/Debian_11_secure/bluetooth.png)

## Disable SSH

### For root

- Edit the `/etc/ssh/ssh_config` file
- Replace `PermitRootLogin yes` by `PermitRootLogin no` if you find the line. If not, add `PermitRootLogin no`

### For all users

- Add Reject rule to the Firewall: in this case Reject rule allows system logging the SSH connections rejected: TCP/22, REJECT IN and REJECT OUT

![](pictures/Debian_11_secure/gufw_ssh.png)

Note that in our case, we refuse any remote access to the current machine. However, if you decide to use remotely the current installation, you need to deal with idle users (inactive users) because they can compromise your system.

### Configure the system for idle users

Idle users are usually a security problem, a user might be idle  maybe because he's out to lunch or because a remote connection hung and  was not re-established. For whatever the reason, idle users might lead  to a compromise:

- because the user's console might be unlocked and can be accessed by an intruder.                     
- because an attacker might be able to re-attach to a closed  network connection and send commands to the remote shell (this is fairly easy if the remote shell is not encrypted as in the case of `telnet`).                     

Some remote systems have even been compromised through an idle (and detached) `screen`.         

Automatic disconnection of idle users is usually a part of the local security policy that must be enforced. There are several ways to do  this:              

- If **bash** is the user shell, a system administrator can set a default `TMOUT` value which will make the shell automatically log off remote idle users. Note that it must be set with the `-o` option or users will be able to change (or unset) it.                     
- Install **timeoutd** and configure `/etc/timeouts` according to your local security policy. The daemon will watch for idle users and time out their shells accordingly.                     
- Install **autolog** and configure it to remove idle users.                     

The `timeoutd` or `autolog` daemons are the preferred method since, after all, users can change  their default shell or can, after running their default shell, switch to another (uncontrolled) shell.

*The detailed procedure is out of the scope of this manual. We configure Firewall to reject all remote access*

## AIDE (Advanced Intrusion Detection Environment)

AIDE is an intrusion detection system that detects changes to files on the local system. It creates a database from the regular expression rules that it finds from the config file. Once this database is initialized it can be used to verify the integrity of the files. 

### Check AIDE in APT

```bash
apt-cache policy aide
```

Output:

```bash
aide:
  Installed: (none)
  Candidate: 0.17.3-4+deb11u1
  Version table:
     0.17.3-4+deb11u1 500
        500 http://security.debian.org/debian-security bullseye-security/main amd64 Packages
     0.17.3-4+b2 500
        500 http://ftp.fr.debian.org/debian bullseye/main amd64 Packages
        500 http://deb.debian.org/debian bullseye/main amd64 Packages
```

### Install AIDE

```bash
apt install aide
```

- The general configuration file for AIDE is located under `/etc/default/aide`

- The rules and other configurations resides under `/etc/aide/`

- The AIDE configuration is located under `/etc/aide/aide.conf`

- The AIDE database is located under `/var/lib/aide/`

Create new database:

```bash
aideinit
```

The process runs during few minutes and creates the baseline AIDE database in `/var/lib/aide/` where you have `aide.db` and `aide.db.new`.

Output:

```bash
Running aide --init...
Start timestamp: 2022-02-22 14:06:27 -0400 (AIDE 0.17.3)
AIDE initialized database at /var/lib/aide/aide.db.new
Verbose level: 6

Number of entries:    205656

---------------------------------------------------
The attributes of the (uncompressed) database(s):
---------------------------------------------------

/var/lib/aide/aide.db.new
  RMD160   : 7x5/c1dpNifnCqEfbegXkgeUYZ8=
  TIGER    : /TaHlucsBgKis1UAWqApNi05/irDr/EK
  SHA256   : IV3S6dK0Vq1MLMBPhkkdbDBbSfxEO5UO
             ZgZLEM5aZRo=
  SHA512   : VwkOKebuBWzrAAhNdeyI/KlgrJGp+Cx7
             E/INRFtcmZnJpMw0ObfyKDFrm8P+OvXb
             8rx7wQ2VMcn1aDfA8aXtNQ==
  CRC32    : ibeVcw==
  HAVAL    : gWjXP+myfjy0ERTHYTTMmtNE+R7trYf1
             7TtzPAdV9Nk=
  GOST     : g0So72BymlRqZ2fx9ZckwTdHaGyy9B9F
             8vsT+WVZAjQ=


End timestamp: 2022-02-22 14:06:27 -0400 (run time: 6m 38s)
```

> Possible warning on `/run/user/1000/doc` directory, but without consequencies

Run a first check :

### Configure AIDE

In the configuration `/etc/aide/aide.conf` file, add exclusion for:

```bash
!/run/user/.*
```

Verify the configuration:

```bash
aide -c /etc/aide/aide.conf --config-check
```

Update AIDE configuration:

```bash
aide -c /etc/aide/aide.conf --update
```

Cf Annex to see information about `/run/user`

### Check system status

```bash
aide -c /etc/aide/aide.conf --check
```

## List of running services

Tip the following command:

```bash
systemctl --type=service --state=running
```

Result:

```bash
UNIT                        LOAD   ACTIVE SUB     DESCRIPTION                                 
accounts-daemon.service     loaded active running Accounts Service                           
avahi-daemon.service        loaded active running Avahi mDNS/DNS-SD Stack                    
clamav-daemon.service        loaded active running Clam AntiVirus userspace daemon
clamav-freshclam.service    loaded active running ClamAV virus database updater
cron.service                loaded active running Regular background program processing daemon
dbus.service                loaded active running D-Bus System Message Bus                   exim4.service                 loaded active running LSB: exim Mail Transport Agent
haveged.service             loaded active running Entropy daemon using the HAVEGE algorithm   
ModemManager.service        loaded active running Modem Manager                               
NetworkManager.service      loaded active running Network Manager                             
packagekit.service            loaded active running PackageKit Daemon
polkit.service              loaded active running Authorization Manager                       
rsyslog.service             loaded active running System Logging Service
rtkit-daemon.service        loaded active running RealtimeKit Scheduling Policy Service       
sddm.service                loaded active running Simple Desktop Display Manager 
systemd-journald.service    loaded active running Journal Service                             
systemd-logind.service      loaded active running Login Service                               
systemd-timesyncd.service   loaded active running Network Time Synchronization
systemd-udevd.service       loaded active running udev Kernel Device Manager 
udisks2.service             loaded active running Disk Manager
unattended-upgrades.service loaded active running Unattended Upgrades Shutdown
upower.service              loaded active running Daemon for power management                 
user@1000.service           loaded active running User Manager for UID 1000                   
wpa_supplicant.service      loaded active running WPA supplicant
```

# Software installation & configuration

## Configure Firefox

- Go to `General` and Check `Restore previous session`
- Go to `Settings` > in `Default Search Engine` select `DuckDuckGo`
- Go to `Connection Settings` > Check `Enable DNS over HTTPS` (Use Cloudflare Provider)
- Check `Play DRM-controlled content`
- Go to `Security` > Check `Enable HTTPS-Only Mode in all windows`

> **Tips**
> 
> DNS is not encrypted by default. Typically,  it can let third parties see what you are doing online and leave, then  change your IP to redirect to websites.
> 
> Therefore, once you use encrypted DNS, you prevent any of these from happening.  Encrypted DNS should be in the form of DNS over TLS, DNS-over-HTTPS  (DoH), or [dnscrypt](https://www.opendns.com/about/innovations/dnscrypt/). These encrypted forms prevent your ISP (Internet Service Provider) from accessing your queries. So, nobody can tamper with what you do online.

- Recommended extensions:
  - uBlock Origin, 
  - DuckDuckGo Privacy Essentials
  - Sidebery

We recommend also:

- WhatRuns extension to identify technologies used to any website.
- Simple Translate to simplify translations when working a lot with English documentation.

<img src="pictures/Debian_11_secure/addons-firefox.png" title="" alt="" data-align="center">

- Configure `/etc/firefox-esr/firefox-esr.js` by adding the following rules:

```bash
//      Recommended configuration
//      Disable telemetry and health reporting
//      https://www.mozilla.org/en-US/privacy/firefox/#health-report
//      https://www.mozilla.org/en-US/privacy/firefox/#telemetry
//      https://gecko.readthedocs.io/en/latest/toolkit/components/telemetry/telemetry/internals/preferences.html
pref("breakpad.reportURL", "");
pref("browser.tabs.crashReporting.sendReport", false);
pref("datareporting.healthreport.documentServerURI", "");
pref("datareporting.healthreport.service.enabled", false);
pref("datareporting.healthreport.uploadEnabled", false);
pref("datareporting.policy.dataSubmissionEnabled", false);
pref("datareporting.policy.dataSubmissionEnabled.v2", false); //      Firefox 43+ ?
pref("dom.ipc.plugins.flash.subprocess.crashreporter.enabled", false);
pref("dom.ipc.plugins.reportCrashURL", false);
pref("toolkit.telemetry.archive.enabled", false);
pref("toolkit.telemetry.cachedClientID", "");
pref("toolkit.telemetry.enabled", false);
pref("toolkit.telemetry.prompted", 2);
pref("toolkit.telemetry.rejected", true);
pref("toolkit.telemetry.server", "");
pref("toolkit.telemetry.unified", false);
pref("toolkit.telemetry.unifiedIsOptIn", true);
pref("toolkit.telemetry.optoutSample", false);
//      Disable sync
pref("identity.fxaccounts.auth.uri", "");
pref("identity.fxaccounts.remote.force_auth.uri", "");
pref("identity.fxaccounts.remote.signin.uri", "");
pref("identity.fxaccounts.remote.signup.uri", "");
pref("identity.fxaccounts.settings.uri", "");
pref("services.sync.autoconnect", false);
pref("services.sync.engine.addons", false);
pref("services.sync.engine.bookmarks", false);
pref("services.sync.engine.history", false);
pref("services.sync.engine.passwords", false);
pref("services.sync.engine.prefs", false);
pref("services.sync.engine.tabs", false);
pref("services.sync.serverURL", "");
//      Turn on Do not Track
pref("privacy.donottrackheader.enabled", true);
pref("privacy.donottrackheader.value", 1);
//      Disable features that have an impact on privacy
//      https://www.mozilla.org/en-US/firefox/geolocation/
pref("accessibility.typeaheadfind", false);
pref("geo.enabled", false);
pref("geo.wifi.logging.enabled", false);
pref("geo.wifi.uri", "");
pref("layout.spellcheckDefault", 0);
//      Disable certificate warning bypass
pref("browser.xul.error_pages.enabled", false);
//      Enable support for Content Security Policy
pref("security.csp.enable", true);
//      Disable Safe Browsing anti-malware
//      Safe Browsing communicates with a third party and leaks the browsing history and also sends metadata about the downloads made.
//      https://support.mozilla.org/en-US/kb/how-does-phishing-and-malware-protection-work
pref("browser.safebrowsing.enabled", false);
pref("browser.safebrowsing.downloads.enabled", false);
pref("browser.safebrowsing.malware.enabled", false);
//      Turn on XSS Filter
pref("browser.urlbar.filter.javascript", true);
//      Restrict third party cookies
pref("network.cookie.cookieBehavior", 1);
//      Enable Flash as it's in a sandbox
pref("plugin.state.flash", 2);

//      Disable Java unless required
pref("plugin.state.java", 0);
pref("plugin.state.npdeployjava1", 0);

//      Disable webcam and microphone unless necessary
pref("media.navigator.enabled", false);
pref("media.navigator.video.enabled", false);

//      Disable Firefox Hello
//      Firefox connects to third-party (Telefonica) servers without asking for permission.
//      https://support.mozilla.org/en-US/kb/firefox-hello-video-and-voice-conversations-online
pref("loop.enabled", false);

//      Disable automatic form filling
pref("signon.autofillForms", false);
pref("signon.prefillForms", false);
pref("signon.rememberSignons", false);

//      Expire master password
pref("signon.expireMasterPassword", true); 
```

## Install KeePassXC

- install KeePassXC via Discover (original site at https://keepassxc.org )

![](./pictures/Debian_11_secure/keepassxc.png)

The installation allow users to create secured database for passwords.

![](./pictures/Debian_11_secure/keepassxc-running.png)

- You can activate the integration with Firefox

<img style="width:100%" src="./pictures/Debian_11_secure/Keepass_firefox_integration.png"/>

- Install KeePassXC-Browser plugin at https://addons.mozilla.org/en-US/firefox/addon/keepassxc-browser/

> Tips
> 
> The end-user must configure at early usage the connection to the KeepassXC database by:
> 
> - Opening KeepassXC Desktop
> 
> - Creating local database
> 
> - Configuring from Keepass-browser the connection to local database (need local database opened, i.e. KeepassXC Desktop opened and connected to its database)
> 
> <img style="width:100%;" src="./pictures/Debian_11_secure/Keepass_firefox_connected.png"/>
> 
> - Once done, synchronization for each item of KeepassXC Desktop and each URL (login and password)
> 
> Example:
> 
> <img src="./pictures/Debian_11_secure/Keepass_firefox_example.png" style="width:100%">
> 
> <img title="" src="./pictures/Debian_11_secure/Keepass_firefox_initiate_login.png" alt="" style="width:100%">
> 
> <img title="" src="./pictures/Debian_11_secure/Keepass_firefox_use_login.png" style="width:100%">

## Containerizable Web browsing (sandboxing)

To contain Firefox if you navigate on insecure websites, we propose to install Firejail which is a Set Owner User ID (SUID). This is an application that restricts untrusted applications. It means that it gives a process (application) its own private view of globally shared kernel and kernel resources.

### Installation

- Download the last DEB release (`firejail_0.9.66_1_amd64.deb` at this date) at https://github.com/netblue30/firejail/releases
- Install the package:

```bash
sudo dpkg -i firejail_0.9.66_1_amd64.deb
```

During installation, the profile, `firejail-default`, is placed in `/etc/apparmor.d` directory, and needs to be loaded into the kernel.

But first install the AppArmor utilities:

```bash
apt install apparmor-utils
```

Now run the following in root mode in `/etc/apparmor.d`:

```bash
sudo aa-enforce firejail-default
```

The output must be:

```bash
Setting /etc/apparmor.d/firejail-default to enforce mode.
```

### Configuration

Firejail configuration is in `/etc/firejail/firejail.config`. You need to modify this configuration file to adapt the level of containerization. See details in §[Firejail configuration](firejail-config) (Annex)

### Usage

First of all you need to know the name of the ethernet interface you can choose to start Firfox with `--net` parameter.

Tip `ip address`

Example of output:

```bash
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s25: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast state DOWN group default qlen 1000
    link/ether dc:4a:3e:5f:5e:06 brd ff:ff:ff:ff:ff:ff
3: wlo1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether dc:53:60:df:3a:ea brd ff:ff:ff:ff:ff:ff
    altname wlp3s0
    inet 192.168.1.36/24 brd 192.168.1.255 scope global dynamic noprefixroute wlo1
       valid_lft 76465sec preferred_lft 76465sec
    inet6 2a01:cb19:156:4500:5f2:180f:80e1:11c6/64 scope global dynamic noprefixroute 
       valid_lft 1749sec preferred_lft 549sec
    inet6 fe80::32e0:eab1:69e4:27cf/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
```

We are here with a laptop configured for the Wifi so `wlo1` is the ethernet interface we will use.

To start Firefox with a good level of security/containerization, we recommend starting it with the following parameters:

```bash
firejail --private --apparmor --seccomp --net=wlo1 firefox-esr -no-remote 
```

| Parameter                  | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--apparmor`               | Flag to enable AppArmor confinement on top of your current Firejail security features.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| `--private`                | If you want Firefox to create a one-time temporary directory, deleting upon closing the application, use `--private` parameter alone. If you specify a path (like `--private=/home/user/firefox` for example), the directory is persistent.                                                                                                                                                                                                                                                                                                                                   |
| `--seccomp`                | You can block applications (Secure Computing Mode) from making system calls outside of a few select ones and limits what the application can access. Use `--seccomp` parameter                                                                                                                                                                                                                                                                                                                                                                                                |
| `--net=ethernet_interface` | Enable a new network namespace and connect it to this ethernet interface      using the standard Linux macvlan driver. Unless specified with option --ip      and --defaultgw, an IP address and a default gateway will be assigned      automatically to the sandbox. The IP address is verified using ARP before      assignment. The address configured as default gateway is the default      gateway of the host. Up to four --net devices can be defined. Mixing      bridge and macvlan devices is allowed. Note: wlan devices are not      supported for this option. |

Typical output when starting Firefox with Firejail is:

```bash
firejail --private --apparmor --seccomp --net=wlo1 firefox-esr -no-remote 
Reading profile /etc/firejail/firefox-esr.profile
Reading profile /etc/firejail/firefox.profile
Reading profile /etc/firejail/whitelist-usr-share-common.inc
Reading profile /etc/firejail/firefox-common.profile
Reading profile /etc/firejail/disable-common.inc
Reading profile /etc/firejail/disable-devel.inc
Reading profile /etc/firejail/disable-exec.inc
Reading profile /etc/firejail/disable-interpreters.inc
Reading profile /etc/firejail/disable-programs.inc
Reading profile /etc/firejail/whitelist-common.inc
Reading profile /etc/firejail/whitelist-runuser-common.inc
Reading profile /etc/firejail/whitelist-var-common.inc
Seccomp list in: !chroot, check list: @default-keep, prelist: unknown,
Parent pid 10485, child pid 10488

Interface        MAC                IP               Mask             Status
lo                                  127.0.0.1        255.0.0.0        UP    
eth0-10485       dc:53:60:df:3a:ea  192.168.1.140    255.255.255.0    UP    
Default gateway 192.168.1.1

Seccomp list in: !chroot, check list: @default-keep, prelist: unknown,
Child process initialized in 1231.80 ms
```

> `--net=wlo1` is not mandatory espacially if you use OpenVPN regularly because in this case you need to adapt your `--net` interface

### Integration to Desktop

We created for Firefox ESR delivered to Debian 11, a *.desktop to load it with Firejail, with AppArmor, secure computing mode and one time temporary directory.

```bash
[Desktop Entry]
Categories=Network;WebBrowser;
Comment[en_US]=Browse the World Wide Web
Comment=Browse the World Wide Web
Exec=firejail --apparmor --seccomp --private --net=wlo1 firefox-esr -no-remote
GenericName[en_US]=Web Browser
GenericName=Web Browser
Icon=firefox-esr
MimeType=text/html;image/png;image/jpeg;image/gif;application/xml;application/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;
Name[en_US]=Firejail Firefox ESR
Name=Firejail Firefox ESR
Path=
StartupNotify=true
StartupWMClass=Firefox-esr
Terminal=false
TerminalOptions=
Type=Application
X-DBUS-ServiceName=
X-DBUS-StartupType=
X-GNOME-FullName=Firejail Firefox ESR Web Browser
X-KDE-SubstituteUID=false
X-KDE-Username=
X-MultipleArgs=false
```

Firejail could make many more than running Firefox. You can use it to check applications, AppImages, etc.

Explore https://firejail.wordpress.com/.

> If you plan to use VPN with Firejail, do not specify `--net` parameter if you want Firejail and Firefox working with and without VPN.

## Oracle VirtualBox

VirtualBox packages are not available in the default Debian 11 repositories. 

Your should move to root profile to perform the installation.

1. Import the VirtualBox repository GPG keys to your system using the following [`wget`](https://linuxize.com/post/wget-command-examples/) commands:

```bash
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
```

Output should be `Ok` each time.

2. add the VirtualBox apt repository to your sources list:

```bash
apt install software-properties-common
add-apt-repository "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
```

`$(lsb_release -cs)` prints the Debian codename (*bullseye* here)

3. Update the package list and install the last version

```bash
apt update && sudo apt install virtualbox-6.1
```

At this point, you have VirtualBox installed on your Debian Bullseye.

The alternative is to download the DEB file directly from https://download.virtualbox.org/virtualbox/6.1.26/.

:bulb: At this time, VirtualBox is available in 6.1.32 version. You can install this last version, the process is the same.

## Install VirtualBox extension pack

The VirtualBox Extension Pack provides several useful functionalities for guest machines such as virtual USB 2.0 and 3.0 devices, support for RDP, images encryption, and more.

The version of the Extension Pack must correspond with the version of the installed VirtualBox.

1. Download the extension file type:

```bash
wget https://download.virtualbox.org/virtualbox/6.1.26/Oracle_VM_VirtualBox_Extension_Pack-6.1.26.vbox-extpack
```

2. Install the extension:

```bash
VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-6.1.26.vbox-extpack
```

During installation, accept the license terms & conditions and type `y` for yes.

You should have the following output:

```bash
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Successfully installed "Oracle VM VirtualBox Extension Pack".
```

VirtualBox is ready to work.

- Start in command line: `virtualbox`
- Via KDE: KDE Menu > `Applications` > `System` > `Oracle VM VirtualBox`

## Stacer

1. Open Discover

2. Search for "Stacer"

![](pictures/Debian_11_secure/stacer.png)

3. Install Stacer

![](pictures/Debian_11_secure/stacer_running.png)

## Instant messaging

We recommand Jami as Instant Messaging and community tool. This is a default package available on Debian KDE. Also, Jami is accessible by Smartphone.

1. Open Discover

2. Search "Jami"

![](pictures/Debian_11_secure/jami_install.png)

3. Install "Jami"

4. Run "Jami"

![](pictures/Debian_11_secure/jami_running.png)

> Jami is available on Smartphone and you can synchronize your account using QR Code

# Markdown Editor

- [ ] Provide installation of Mark Text

# Anonymity & privacy on the Internet

In this section, we try to discuss about online anonymity & privacy. We explain first the context and we propose some tooling to help getting the best anonymity and privacy context to work properly and with confidence.

Solutions are different and answer to different usages. 

In this chapter, we cover `Tor Browser`, `macchanger`, `Anonsurf`, `Protonmail`, `protonVPN`, and `I2P`.

Other solutions exist such as `Nipe` (force connexions to Tor Network) or solutions to share files such as `OnionShare` but we try to find the most useful tools for our needs.

> :warning: `Anonsurf` and `Nipe` are not included in APT repository. Updates must be manual.

## Tor Browser

### What is Tor Browser ?

Tor Browser is a modified Firefox which route all its requests to Tor Network, protecting you against tracking and spying.. When the browser is closed, it deletes all privacy-sensitive website data such as browsing history and cookies.

Tor Browser provides access to internet but also ".onion" websites, Tor hidden services websites offering a more private browsing (deep web).

All Tor Browser data is encrypted and relayed three times over the Onion Router network, which is composed of thousands of volunteer-run servers, which are known as Tor relays.

This encryption and relaying of your browsing data prevents anyone who is watching from detecting which websites you are visiting. Anyone can see is that you are using Tor.

However, remember that your Internet Service Provider (ISP) can detect when you’re using the Tor Browser, which can make you the target of increased surveillance by 
both the ISP and the government.

The Tor Browser is configured to make all users look the same, making it
 nearly impossible for users to be fingerprinted based on their browser 
and device information.

### Onion Network

Encrypted data is sent through a series of network-based nodes called onion routers: there are 4 nodes between your computer and the website you want to connect.

Each node decrypt and encrypt data that slows your internet connection.

All of this keeps the sender anonymous, thanks to how each intermediary node only knows the location of the previous and next node. This provides high-level anonymity and security.

### Weakness

Tor Browser and Network are considered an excellent way to protect online privacy and anonymity. But since each node server is a volunteer-operated, you never know who operates the relays that your data is travelling through.

While this isn’t an issue for most of the trip (since each relay only has access to the previous and next relays in the network), it is an issue with the exit node.

The exit node removes the final layer of encryption on your data. While this doesn’t tell the exit node what your original IP address or your geographical location is, it could spy on your activity if the website you’re visiting isn’t a secured HTTPS website.

Also, the Tor Browser is based on the Mozilla Firefox platform, it means that it is susceptible to the same attacks that other browsers are.

When you install the Tor Browser, it comes preconfigured with the most secure privacy settings. That means Javascript has been disabled, extensions are disabled, and the browser is configured to warn you if an attempt is made to download a file and open it in another application.

This means you should never change the default settings in the Tor Browser.

While the Tor Browser does an excellent job of protecting your privacy and anonymity, it really shouldn’t be used as your daily driver browser because it slows down your browsing (traffic goes through a series of relays, getting encrypted or decrypted along the way, things slow way down. This means Tor is a lousy option for streaming video, online gaming or downloading files)

Another reason you don’t want to use the Tor Browser for your daily web browsing is that it draws attention to you. The Tor Browser prevents your ISP from seeing what websites you’re visiting, but it does not prevent the ISP from seeing that you’re using Tor. That could make them suspicious about what you’re doing. That makes you a target for being monitored.

![](pictures/Debian_11_secure/tor_on.png)

### Use Tor over VPN

To protect your privacy on a daily basis, prefer VPN rather than Tor Browser to hide your IP address. 

If you want more privacy and hide to your ISP the use of Tor, you must use Tor Browser over a VPN connection. A VPN’s ability to hide your Tor usage from your ISP and from government authorities makes for a valuable addition to your online privacy arsenal.

### Installation

Go to https://www.torproject.org and download the last version of `Tor browser` in `tar.xz` format and the Signature (*.asc file)

*In the following procedure, this is the 11.0.4 version*

#### Verify the downloads

Tor Browser binaries: tor-browser-linux64-11.0.4_en-US.tar.xz

Tor Browser Signature: https://dist.torproject.org/torbrowser/11.0.4/tor-browser-linux64-11.0.4_en-US.tar.xz.asc

```bash
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJh2pq5AAoJEOU9mJqeLUe/hUIP/ihKMJRs88To2dNsaRk9PPWm
w7kAHBCgWsQRSvgdqa5KJxxyFKCKz88pb2qV/prKRrIDnqyh8rV+T6uxGwa+c4yW
fkUDeWsJmfENVqZCmr/I3QJXNIW13wi7UH1t6VVBVwqqfDJod/o7ts0iZqvx1Phd
ez8OR5nX4jZFF4JRRMiCXnHE4jx4EVqSG/yp9fkgxzY7TTx3N4buIzYCXjOjzSdH
F1Qv5BQ+9vUZpYhYOn8xdNSDmr73DP8WqaU9FN6VNgbvH8QGV5DQ5MLudTNUxuYU
9lOmrBM205DxbLp8PaGBlSD9r1WcS9MQV9YYsHd9yVQ2bDzMZwCeFbI5IimnEoSS
MZEraXuaFZ3T0zwalzu0/NNno6F50ivEx9dgo9+9c3zive4zAhbx2Va2H1x7q5+x
18Uqc3MOghgacrh8DyCxIFFRuq330QHD8TUQ9MhAo8y8KdR7Du3jhlMryjk6lPtN
To3kfwG/3KRt+XSM0UnzcMEwVPmUpdWZ/3HB3Ro3a1PoQ1yI9y4YdFqngiTtAWXr
GUl/sEwqM6GdZ2kMKlfEp/d3P2YZWOoBQ1VWmDXU8/etoxZGF0NhPSfU2/pIexRG
EedRaKrB0XZoJBFfS5NVIuNm64TbBRUyfT7Yc8AwM+rX7chb+wYOtsktp5zpEsTJ
KWVEa6NcKroOUb79P743
=ILAL
-----END PGP SIGNATURE-----
```

1. Import the signing keys

Command:

```bash
gpg --auto-key-locate nodefault,wkd --locate-keys torbrowser@torproject.org
```

Output:

```bash
gpg: clef 4E2C6E8793298290 : clef publique « Tor Browser Developers (signing key) <torbrowser@torproject.org> » importée
gpg:       Quantité totale traitée : 1
gpg:                     importées : 1
pub   rsa4096 2014-12-15 [C] [expire : 2025-07-21]
      EF6E286DDA85EA2A4BA7DE684E2C6E8793298290
uid          [ inconnue] Tor Browser Developers (signing key) <torbrowser@torproject.org>
sub   rsa4096 2021-09-17 [S] [expire : 2023-09-17]
```

2. Export the key (that generates `tor.keyring` file)

```bash
gpg --output ./tor.keyring --export 0xEF6E286DDA85EA2A4BA7DE684E2C6E8793298290
```

3. Verify the signature

Command:

```bash
gpgv --keyring ./tor.keyring /home/vissol/Softs/tor-browser-linux64-11.0.4_en-US.tar.xz.asc /home/vissol/Softs/tor-browser-linux64-11.0.4_en-US.tar.xz
```

Use Tor Browser

1. Unzip `tor-browser-linux64-11.0.4_en-US.tar.xz` file

2. Rename the generated `tor-browser_en-US` in `tor-browser-linux64-11.0.4_en-US`

3. Go into `tor-browser-linux64-11.0.4_en-US`, rename `start-tor-browser.desktop` in `start-tor-browser_11.0.4.desktop` and run:

```bash
./start-tor-browser_11.0.4.desktop
```

4. The execution creates a new `start-tor-browser.desktop` file you can copy to your Desktop, click on it and run Tor Browser.

5. For the first time click on "Connect" button but select "Connect always automatically"

![](pictures/Debian_11_secure/tor_first_connection.png)

:bulb: For updates, the Tor Browser is able to update itself. however, it is possible to integrate the Tor repository to your Debian See https://support.torproject.org/apt/.

6. Configure Tor Browser:
   1. `Privacy & Security` > `Logins and Passwords` > Select `Show alerts about passwords for breached websites`
   2. `Privacy & Security` > `History` > Select `Never remember history`
   3. `Privacy & Security` > `Security` > `Safer` 
   4. `Privacy & Security` > `Deceptive Content and Dangerous Software Protection` > `Select Block dangerous and deceptive content` & `Block dangerous downloads`
   5. `Privacy & Security` > `HTTPS-Only Mode` > Select `Enable HTTPS-Only Mode in all windows`
   6. `Tor` > `Advanced` > Select `This computer goes through a firewall that only allows connections to certain ports`

## VPN

Proton services offers also a VPN (ProtonVPN) for Debian. In its free version, this VPN is limited (3 locations, 109 servers), but it works well. This VPN 

Get the DEB stable release in https://protonvpn.com/support/official-linux-vpn-debian/

1. Double-click the DEB package to install the repo using Discover (default package manager)

2. Update the package list: `sudo apt-get update`

3. Install the ProtonVPN Linux app: `sudo apt-get install protonvpn`

4. Run ProtonVPN and test the connection

:bulb: The ProtonVPN installation creates a `/etc/apt/sources.list.d/protonvpn-stable.list` where the reference of the ProtonVPN repository is stored. This allows your system to update ProtonVPN.

## MAC address

### Who is MAC?

Every network interface on your Linux operating system distribution is associated with a unique number called **MAC** (**Media Access Control**). The wireless and Ethernet network modules are examples of commonly used network interfaces on a Linux operating system. **MAC** serves a unique role in identifying these network interfaces through system protocols and programs.

For example, through **DHCP** (**Dynamic Host Control Protocol**), a network interface is assigned an IP address by a network router automatically. In this case, the **MAC** address acts as a reference manual for networking devices like the  router so that these devices know the identity of the other network  devices they are communicating with or, in this case, [assigning IP addresses](https://www.linuxshelltips.com/find-ip-addresses-are-connected-to-linux/).

### Why changing MAC?

The **MAC** address is different from an IP address such that it is hardware-oriented whereas an IP address is  software-oriented. Therefore, an IP address can be permanently changed  whereas changing a **MAC** address is only temporary. If you restart your machine it will default to its original manufacturer’s value.

Three prime reasons as to why you might need to temporarily change your MAC address stand out:

- You do not trust the public network you are using and therefore  don’t want your MAC address to be exposed as it can be used to  permanently identify your machine whenever you are on a network.
- A firewall or router has been used to block your original MAC address to deny you access to a specific network.
- Airport WiFi and other public networks operate on the **“Limited Time Access**” rule when it comes to gifting free internet to their clients. Changing the MAC address can bypass this limitation.

### Install MAC Changer

You install `macchanger` with the following command:

```bash
sudo apt install macchanger
```

During the installation, you’ll be asked to specify whether `macchanger` should be set up to run  automatically every time a network device is brought up or down. This  gives a new MAC address whenever you attach an Ethernet cable or  re-enable WiFi.

![](pictures/Debian_11_secure/macchanger1.png)

I recommend not to run it automatically, unless you really need to  change your MAC address every time. So, choose No (by pressing tab key)  and hit Enter key to continue.

### Running macchanger

1. Get first you network card interface.

Example

```bash
vissol@debian-dev:~$ ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp0s25: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
    link/ether dc:4a:3e:5f:5e:06 brd ff:ff:ff:ff:ff:ff
3: wlo1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DORMANT group default qlen 1000
    link/ether dc:53:60:df:3a:ea brd ff:ff:ff:ff:ff:ff
    altname wlp3s0
```

Here we are in Wifi so `wlo` is our active network card.

2. Turn off you network card

```bash
sudo ip link set dev wlo1 down
```

3. Run `macchanger` and set a random MAC address

```bash
sudo macchanger -r wlo1
```

3. Turn back your network card

```bash
sudo ip link set dev wlo1 up
```

3. To revert the MAC address to its original hardware value, run:

```bash
sudo macchanger -p wlo1
```

:bulb: You can use `iproute2` to modify your MAC address also

```bash
#Turn of your network card
sudo ip link set dev wlo1 down
#set new MAC Address
sudo ip link set dev wlo1 address XX:XX:XX:XX:XX:XX
#turn network back
sudo ip link set dev wlo1 up
```

## Hide your IP and clean your RAM

Rather than `Tor Browser`, you can choose to use `Anonsurf`.

`Anonsurf` is a script made by the development team at ParrotSec. This script was made to provide users with system-wide anonymization.

Anything you do while you have `Anonsurf` started on your system would be nearly untraceable. Anonsurf not only routes all your traffic through Tor, but it also lets you start `i2p` services and clear any traces left on the user disk.

:bulb: `i2p` provides alternate services to Tor

![](pictures/Debian_11_secure/i2p.png)

`Anonsurf` also kills away all dangerous applications by virtue of the `Pandora bomb`, so you don't need to worry about having a Tor browser and other scripts running to hide your system. 

:bulb: The best part is that all this is contained in a simple `start`/`stop` function.

`Anonsurf` allows you to use your usual Browser to navigate, but it requires to disable Firewall (`gufw`).

### Install I2P

Go to https://geti2p.net/en/download/debian 

```bash
sudo apt-get update
sudo apt-get install apt-transport-https lsb-release curl
#Add repository
echo "deb [signed-by=/usr/share/keyrings/i2p-archive-keyring.gpg] https://deb.i2p2.de/ $(lsb_release -sc) main" \
  | sudo tee /etc/apt/sources.list.d/i2p.list
#Download the key used to sign the repository
curl -o i2p-archive-keyring.gpg https://geti2p.net/_static/i2p-archive-keyring.gpg
#Display the key fingerprint. 
gpg --keyid-format long --import --import-options show-only --with-fingerprint i2p-archive-keyring.gpg
```

Verify that this key fingerprint matches the output:    

```bash
  7840 E761 0F28 B904 7535  49D7 67EC E560 5BCF 1346
```

```bash
# Copy the keyring to the keyrings directory: 
sudo cp i2p-archive-keyring.gpg /usr/share/keyrings
# Notify your package manager of the new repository by entering
sudo apt-get update
# install I2P
sudo apt-get install i2p i2p-keyring
```

Add `usr/sbin` to `/etc/profile`

### Install Anonsurf

1. Clone Git repository

Go to ~/Downloads directory and clone git repository

```bash
$ git clone https://github.com/Und3rf10w/kali-anonsurf.git
```

Jump to kali-anonsurf directory

```bash
cd kali-anonsurf
```

Give installer execute permissions

```bash
chmod +x installer.sh
```

Run installer script

```bash
./installer.sh
```

Once installed, you can see all parameters:

- **start** starts the anon mode

- **stop** finishes the anon session

- **restart** combines “stop” and “start” options

- **start-bridge** starts system-wide Tor tunnel with Obfs4 bridge support

- **changeid**   restarts Tor to change identity

- **enable-boot**
  
   enables Anonsurf at boot
  
  - Also by $ systemctl enable anonsurf

- **disable-boot** 
  
  disables Anonsurf at boot
  
  - Also by $ systemctl disable anonsurf

- **status**
  
   checks whether Anonsurf is working properly
  
  - Uses the *Nyx* application to display information about Tor service, bandwidth, nodes, etc.

- **myip** checks your IP and verifies your Tor connection

- **dns** replaces your DNS with the OpenNIC DNS servers.

To ensure all is working, tip:

```bash
sudo anonsurf
```

Output should be:

![](pictures/Debian_11_secure/anonsurf.png)

Launch a secure Tor channel to direct your traffic, which will change your IP every five to ten minutes by running

```bash
sudo anonsurf start
```

:warning: To use `anonsurf`, disable UFW firewall. `anonsurf` uses already `iptables` to force your connections to Tor Network.

Output should be:

![](pictures/Debian_11_secure/anonsurf2.png)

At any time you can:

- check your IP: `sudo anonsurf myip`
- check the status of the module: `sudo anonsurf status`
- change dynamically your identity: `sudo anonsurf changeid`

Stop the service like this:

```bash
sudo anonsurf stop
```

:bulb: Follow the updates of this script because there is no APT repository.

## Advice for anonymity & privacy

For simple but secure usage, the most efficient way is to setup VPN in combination with `Tor Browser`. For specific usage, you can use `macchanger` but before setting up VPN.

# Desktop environment configuration

Installation comprise:

- Blue innovit wallpaper

- Global theme: Breeze Dark + Nordic KDE

- Icons: BeautyLine

- Choose Nordic Login Screen + InnovIT bg wallpaper.

- Window Decorations: Nordic

Password are stored in `/home/<username>/Desktop/Passwords.kdbx`.

Jami is installed and an account is created.

A protonmail account is also created.

# Enable KDE Wallet management

KDE Wallet Manager is a tool to manage passwords on the KDE Plasma system. 

By using the KWallet subsystem it not only allows you to keep your own secrets but also to access and manage the passwords of every application that integrates with KWallet. 

In our usage, KDE Wallet store the Wifi passphrase.

By default, if you store a password in KDE Wallet, each time you connect to Wifi the system requires you to set your password session. To avoid this, you must enable the automatic unlocking of KDE Wallet when entering in a session:

- Edit `/etc/pam.d/sddm`

- uncomment (comment is `-` character at the beginning of the line) the 2 following lines:

```bash
auth            optional        pam_kwallet5.so
session         optional        pam_kwallet5.so auto_start
```

More information in [KDE Wallet - ArchWiki](https://wiki.archlinux.org/title/KDE_Wallet)

# System information

Install `lshw`:

```bash
sudo apt-get install lshw
```

Run the following command to get all the information about the system:

```bash
sudo lshw
```

> At the end of the installation run:
> 
> - hostnamectl
> 
> - lscpu
> 
> - lshw

# ANNEX

## Update the Encryption passphrase of LUKS

Verify first where is the encrypted partition (normally `sda3`):

```bash
cat /etc/cryptab
```

To modifiy the passphrase, run:

```bash
sudo crypsetup luksAddKey /dev/sda3
```

If `/dev/sda3` exists.

Output should be:

```bash
sudo cryptsetup luksAddKey /dev/sda3       
Enter any existing passphrase:  
Enter new passphrase for key slot:  
Verify passphrase:
```

## Supported file systems

Debian system gets its file systems supported list in /proc/filesystems file.

No additional configuration applied to the standard Debian configuration.

See supported file systems:

```bash
cat /proc/filesystems
```

Output:

```bash
vissol@debian-dev:/etc/modprobe.d$ cat /proc/filesystems
nodev   sysfs
nodev   tmpfs
nodev   bdev
nodev   proc
nodev   cgroup
nodev   cgroup2
nodev   cpuset
nodev   devtmpfs
nodev   debugfs
nodev   tracefs
nodev   securityfs
nodev   sockfs
nodev   bpf
nodev   pipefs
nodev   ramfs
nodev   hugetlbfs
nodev   devpts
nodev   mqueue
nodev   pstore
nodev   efivarfs
        btrfs
        ext3
        ext2
        ext4
nodev   autofs
nodev   configfs
        fuseblk
nodev   fuse
nodev   fusectl
        squashfs
        vfat
nodev   cifs
nodev   smb3
```

## About AIDE configuration...

`/run/user/$uid` is created by [`pam_systemd`](http://www.freedesktop.org/software/systemd/man/pam_systemd.html) (**pam_systemd** registers user sessions with the systemd login manager [systemd-logind.service(8)](https://www.freedesktop.org/software/systemd/man/systemd-logind.service.html#), and hence the systemd control group hierarchy.) and used for storing files used by running processes for that user. These might be things such as your keyring daemon, pulseaudio, etc.

Prior to [systemd](http://www.freedesktop.org/wiki/Software/systemd/), these applications typically stored their files in `/tmp`. They couldn't use a location in `/home/$user` as home directories are often mounted over network filesystems, and these files should not be shared among hosts. `/tmp` was the only location specified by the [FHS](http://www.pathname.com/fhs/) which is local, and writable by all users.

However storing all these files in `/tmp` is problematic as `/tmp` is writable by everyone, and while you can change the ownership & mode on the files being created, it's more difficult to work with.

So systemd came along and created `/run/user/$uid`. This directory is local to the system and only accessible by the target user. So applications looking to store their files locally no longer have to worry about access control.  

It also keeps things nice and organized. When a user logs out, and no active sessions remain, `pam_systemd` will wipe the `/run/user/$uid` directory out. With various files scattered around `/tmp`, you couldn't do this.

According [to the latest draft of FHS (File Hierarchy Standard)](http://www.linuxbase.org/betaspecs/fhs/fhs.html#runRuntimeVariableData), /run:

> This directory contains system information data describing the system since it was booted. Files under this directory must be cleared (removed or truncated as appropriate) at the beginning of the boot process.
> 
> The purposes of this directory were once served by /var/run. In general, programs may continue to use /var/run to fulfill the requirements set out for /run for the purposes of backwards compatibility. Programs which have migrated to use /run should cease their usage of /var/run, except as noted in the section on /var/run.
> 
> Programs may have a subdirectory of /run; this is encouraged for programs that use more than one run-time file. Users may also have a subdirectory of /run, although care must be taken to appropriately limit access rights to prevent unauthorized use of /run itself and other subdirectories.

In the case of the `/run/user` directory, is used by the different user services, like dconf, pulse, systemd, etc. that needs a place for their lock files and sockets. There are as many directories as different users UID's are logged in the system.

AIDE configuration options (help):

```bash
   # Here are all the things we can check - these are the default rules
   #
   #p:      permissions
   #ftype:  file type
   #i:      inode
   #n:      number of links
   #l:      link name
   #u:      user
   #g:      group
   #s:      size
   #b:      block count
   #m:      mtime
   #a:      atime
   #c:      ctime
   #S:      check for growing size
   #I:      ignore changed filename
   #md5:    md5 checksum
   #sha1:   sha1 checksum
   #sha256: sha256 checksum
   #sha512: sha512 checksum
   #rmd160: rmd160 checksum
   #tiger:  tiger checksum
   #haval:  haval checksum
   #crc32:  crc32 checksum
   #R:      p+ftype+i+l+n+u+g+s+m+c+md5
   #L:      p+ftype+i+l+n+u+g
   #E:      Empty group
   #>:      Growing file p+ftype+l+u+g+i+n+S
   #The following are available if you have mhash support enabled:
   #gost:   gost checksum
   #whirlpool: whirlpool checksum
   #The following are available and added to the default groups R, L and >
   #only when explicitly enabled using configure:
   #acl:    access control list
   #selinux SELinux security context
   #xattrs:  extended file attributes
   #e2fsattrs: file attributes on a second extended file system

   # You can also create custom rules - my home made rule definition goes like this
   #
   MyRule = p+i+n+u+g+s+b+m+c+md5+sha1

   # Next decide what directories/files you want in the database

   /etc p+i+u+g     #check only permissions, inode, user and group for etc
   /bin MyRule      # apply the custom rule to the files in bin
   /sbin MyRule     # apply the same custom rule to the files in sbin
   /var MyRule
   !/var/log/.*     # ignore the log dir it changes too often
   !/var/spool/.*   # ignore spool dirs as they change too often
   !/var/adm/utmp$  # ignore the file /var/adm/utmp
```

## Avoid Mounting automatically USB stick

You should consider not mounting automatically your USB and specify its ownership.

First identify your device:

```bash
df 
```

Output:

```bash
Filesystem                       1K-blocks      Used Available Use% Mounted on
udev                               8100688         0   8100688   0% /dev
tmpfs                              1626316     60808   1565508   4% /run
/dev/mapper/debian--dev--vg-root  23897936  18334652   4326292  81% /
tmpfs                              8131572    330476   7801096   5% /dev/shm
tmpfs                                 5120         4      5116   1% /run/lock
/dev/mapper/debian--dev--vg-home 922826412 195331288 680548412  23% /home
/dev/mapper/debian--dev--vg-tmp    1886280     23984   1748428   2% /tmp
/dev/mapper/debian--dev--vg-var    9545920   5536284   3505012  62% /var
/dev/sda2                           483946    294936    164025  65% /boot
/dev/loop0                           56832     56832         0 100% /snap/core18/2253
/dev/loop1                          217344    217344         0 100% /snap/code/88
/dev/loop2                           56960     56960         0 100% /snap/core18/2284
/dev/loop5                          541312    541312         0 100% /snap/pycharm-community/268
/dev/loop4                          541312    541312         0 100% /snap/pycharm-community/267
/dev/loop6                          221056    221056         0 100% /snap/code/87
/dev/loop3                          113536    113536         0 100% /snap/core/12725
/dev/sda1                           523248      4960    518288   1% /boot/efi
tmpfs                              1626312        84   1626228   1% /run/user/1000
/dev/sdb1                          1878388        24   1764752   1% /media/vissol/3dbb9833-fbbf-46ff-876a-d9b016ba8c61
```

Here is `/dev/sdb1` and `/media/vissol/3dbb9833-fbbf-46ff-876a-d9b016ba8c61` interesting us. We select this device to integrate him in the `/etc/fstab` file by adding the following line at the end of the file:

```bash
/dev/sdb1 /media/vissol/3dbb9833-fbbf-46ff-876a-d9b016ba8c61 ext4 noauto,nosuid,nodev,uid=vissol        0       2
```

- `noauto` avoid the Stick to mount automatically

- uid=<username> : stick is mounted only by <username> profile.

## Security repository for Debian

In order to receive the latest Debian security advisories, subscribe to the [debian-security-announce](https://lists.debian.org/debian-security-announce/) mailing list.

You can use [apt](https://packages.debian.org/stable/admin/apt) to easily get the latest security updates. This requires a line such as

```
deb http://security.debian.org/debian-security bullseye-security main contrib non-free
```

in your `/etc/apt/sources.list` file. 

Then execute:

```bash
apt-get update && apt-get upgrade 
```

to download and apply the pending updates. The security archive is signed with the normal Debian archive [signing keys](https://ftp-master.debian.org/keys.html).

## KDE: Configuring Display mode & definition

- Go to System Settings

![](./pictures/Debian_11_secure/settings.png)

- Click on Workspace Theme and select Breeze Dark. Click on Apply

![](./pictures/Debian_11_secure/breeze-dark.png)

The look & feel turns Dark:![](./pictures/Debian_11_secure/dark.png)

- In Display and Monitor, modify if necessary, the Resolution of the screen and click Apply:

![](./pictures/Debian_11_secure/resolution.png)

## Advice for KDE theme selection

Choose the Sweet-Mars, colorful and innovative Theme.

![](pictures/Debian_11_secure/KDE_SweetMars.png)

# Wifi configuration

Wifi is sometimes not recognized after a standard installation. To verify if Wifi card is recognized, tip:

```bash
ip link
```

If Wifi card is recognized, you can see an output with "wlo..." or "wlp...". 

**Example:**

```bash
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode...
link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp0s25: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast...
link/ether 00:24:e8:a1:13:65 brd ff:ff:ff:ff:ff:ff
3: wlp0s29f7u3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state...
link/ether e8:94:f6:16:7f:f3 brd ff:ff:ff:ff:ff:ff
```

Here is `wlp0s29f7u3`

But in some cases no Wifi ouput.

**Example:**

```bash
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode...
link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp0s25: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast...
link/ether 00:24:e8:a1:13:65 brd ff:ff:ff:ff:ff:ff
```

To identify the Wifi card, tip:

```bash
lspci | grep -i "net" | cut -d: -f3
```

If you really have a Wifi card installed you should see for example:

```bash
Intel Corporation Ethernet Connection (3) I218-LM (rev 03)
Intel Corporation Wireless 7265 (rev 48)
```

In this case for **HP Elitebook 840** you need to search the firmware on the internet: "debian intel 7265" (example using DuckDuckGo):

You find the page https://wiki.debian.org/iwlwifi were you can fond the driver for Intel 7265 WIFI Adapter.

1. Add additional repositories

```bash
deb http://deb.debian.org/debian bullseye main contrib non-free
deb-src http://deb.debian.org/debian bullseye main contrib non-free

deb http://deb.debian.org/debian-security/ bullseye/updates main contrib non-free
deb-src http://deb.debian.org/debian-security/ bullseye/updates main contrib non-free

deb http://deb.debian.org/debian bullseye-updates main contrib non-free
deb-src http://deb.debian.org/debian bullseye-updates main contrib non-free
```

2. Update the list of available packages and install wifi drivers packages:

```bash
apt update && apt install firmware-iwlwifi
```

3. Reinsert this module to access firmware:

```bash
modprobe -r iwlwifi ; modprobe iwlwifi
```

Another way for Buster (Debian 10) is to directly download the DEB file from repository: [Debian -- Package Download Selection -- firmware-iwlwifi_20210315-3_all.deb](https://packages.debian.org/bullseye/all/firmware-iwlwifi/download), execute the file with Discover (Software Center for KDE) and restart the PC.

After Wifi installation, you should be able to see Wifi connections in the Debian task bar:

![](./pictures/Debian_11_secure/wifi.png)

# SecureBoot for ZBook 17 G3

Here, we display:

- the Platform Key (PK): this is the main key. This keys, usually belonging to the platform owner,  controls if the ownership can be changed, or if other keys can be modified.
- The Key Exchange Key (KEK): these keys control which certificates can be used to sign images.
- The Authorized Signatures Database (DB): this database contains authorized signing certificates,  but also some hashes. Any image, either signed with a certificate enrolled in DB, or having a hash  stored in DB, will be allowed to boot.
- The Forbidden Signature Database (DBX): this database stores forbidden certificates and images  hashes. Any Image listed here will never be allowed to run (even if also listed in DB).

```bash
vissol@debian-dev5:~$ mokutil --help
Usage:
  mokutil OPTIONS [ARGS...]

Options:
  --help                                Show help
  --list-enrolled                       List the enrolled keys
  --list-new                            List the keys to be enrolled
  --list-delete                         List the keys to be deleted
  --import <der file...>                Import keys
  --delete <der file...>                Delete specific keys
  --revoke-import                       Revoke the import request
  --revoke-delete                       Revoke the delete request
  --export                              Export keys to files
  --password                            Set MOK password
  --clear-password                      Clear MOK password
  --disable-validation                  Disable signature validation
  --enable-validation                   Enable signature validation
  --sb-state                            Show SecureBoot State
  --test-key <der file>                 Test if the key is enrolled or not
  --reset                               Reset MOK list
  --generate-hash[=password]            Generate the password hash
  --ignore-db                           Ignore DB for validation
  --use-db                              Use DB for validation
  --import-hash <hash>                  Import a hash into MOK or MOKX
  --delete-hash <hash>                  Delete a hash in MOK or MOKX
  --set-verbosity <true/false>          Set the verbosity bit for shim
  --pk                                  List the keys in PK
  --kek                                 List the keys in KEK
  --db                                  List the keys in db
  --dbx                                 List the keys in dbx
  --timeout <-1,0..0x7fff>              Set the timeout for MOK prompt

Supplimentary Options:
  --hash-file <hash file>               Use the specific password hash
  --root-pw                             Use the root password
  --simple-hash                         Use the old password hash method
  --mokx                                Manipulate the MOK blacklist
vissol@debian-dev5:~$ mokutil --list-enrolled
[key 1]
SHA1 Fingerprint: 53:61:0c:f8:1f:bd:7e:0c:eb:67:91:3c:9e:f3:e7:94:a9:63:3e:cb
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            ed:54:a1:d5:af:87:48:94:8d:9f:89:32:ee:9c:7c:34
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN=Debian Secure Boot CA
        Validity
            Not Before: Aug 16 18:09:18 2016 GMT
            Not After : Aug  9 18:09:18 2046 GMT
        Subject: CN=Debian Secure Boot CA
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:9d:95:d4:8b:9b:da:10:ac:2e:ca:82:37:c1:a4:
                    cb:4a:c3:1b:42:93:c2:7a:29:d3:6e:dd:64:af:80:
                    af:ea:66:a2:1b:61:9c:83:0c:c5:6b:b9:35:25:ff:
                    c5:fb:e8:29:43:de:ce:4b:3d:c6:12:4d:b1:ef:26:
                    43:95:68:cd:04:11:fe:c2:24:9b:de:14:d8:86:51:
                    e8:38:43:bd:b1:9a:15:e5:08:6b:f8:54:50:8b:b3:
                    4b:5f:fc:14:e4:35:50:7c:0b:b1:e2:03:84:a8:36:
                    48:e4:80:e8:ea:9f:fa:bf:c5:18:7b:5e:ce:1c:be:
                    2c:80:78:49:35:15:c0:21:cf:ef:66:d5:8a:96:08:
                    2b:66:2f:48:17:b1:e7:ec:82:8f:07:e6:ca:e0:5f:
                    71:24:39:50:0a:8e:d1:72:28:50:a5:9d:21:f4:e3:
                    61:ba:09:03:66:c8:df:4e:26:36:0b:15:0f:63:1f:
                    2b:af:ab:c4:28:a2:56:64:85:8d:a6:55:41:ae:3c:
                    88:95:dd:d0:6d:d9:29:db:d8:c4:68:b5:fc:f4:57:
                    89:6b:14:db:e0:ef:ee:40:0d:62:1f:ea:58:d4:a3:
                    d8:ba:03:a6:97:2e:c5:6b:13:a4:91:77:a6:b5:ad:
                    23:a7:eb:0a:49:14:46:7c:76:e9:9e:32:b4:89:af:
                    57:79
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            Authority Information Access: 
                CA Issuers - URI:https://dsa.debian.org/secure-boot-ca

            X509v3 Authority Key Identifier: 
                keyid:6C:CE:CE:7E:4C:6C:0D:1F:61:49:F3:DD:27:DF:CC:5C:BB:41:9E:A1

            Netscape Cert Type: critical
                SSL Client, SSL Server, S/MIME, Object Signing, SSL CA, S/MIME CA, Object Signing CA
            X509v3 Extended Key Usage: 
                Code Signing
            X509v3 Key Usage: critical
                Digital Signature, Certificate Sign, CRL Sign
            X509v3 Basic Constraints: critical
                CA:TRUE
            X509v3 Subject Key Identifier: 
                6C:CE:CE:7E:4C:6C:0D:1F:61:49:F3:DD:27:DF:CC:5C:BB:41:9E:A1
    Signature Algorithm: sha256WithRSAEncryption
         77:96:3e:47:c9:ce:09:cf:8b:89:ce:59:ed:26:0e:26:0b:b9:
         ad:a9:2b:bd:a1:eb:88:79:02:ff:31:de:fe:f5:6a:07:ef:61:
         13:11:70:1e:bf:9c:4e:66:6c:e1:62:12:97:01:57:65:47:dd:
         4a:c6:f7:f4:de:a8:f1:13:62:cc:83:57:ac:3c:a6:91:15:af:
         55:26:72:69:2e:14:cd:dd:4d:b3:d1:60:24:2d:32:4f:19:6c:
         11:5e:f2:a3:f2:a1:5f:62:0f:30:ae:ad:f1:48:66:64:7d:36:
         44:0d:06:34:3d:2e:af:8e:9d:c3:ad:c2:91:d8:37:e0:ee:7a:
         5f:82:3b:67:8e:00:8a:c4:a4:df:35:16:c2:72:2b:4c:51:d7:
         93:93:9e:ba:08:0d:59:97:f2:e2:29:a0:44:4d:ea:ee:f8:3e:
         02:60:ca:15:cf:4e:9a:25:91:84:3f:b7:5a:c7:ee:bc:6b:80:
         a3:d9:fd:b2:6d:7a:1e:63:14:eb:ef:f1:b0:40:25:d5:e8:0e:
         81:eb:6b:f7:cb:ff:e5:21:00:22:2c:2e:9a:35:60:12:4b:5b:
         5f:38:46:84:0c:06:9c:cf:72:93:62:18:ee:5c:98:d6:b3:7d:
         06:25:39:95:df:4e:60:76:b0:06:7b:08:b0:6e:e3:64:9f:21:
         56:ad:39:0f
vissol@debian-dev5:~$ mokutil --pk
[key 1]
SHA1 Fingerprint: ef:40:e8:8b:7f:2c:c7:18:a0:87:05:1d:b5:d5:d4:c2:60:43:c5:aa
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            77:58:a5:f8:cb:1d:cf:d3:2c:6a:7f:8f:03:81:6b:04
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=US, O=Hewlett-Packard Company, CN=Hewlett-Packard Printing Device Infrastructure CA
        Validity
            Not Before: Aug 23 00:00:00 2013 GMT
            Not After : Aug 23 23:59:59 2033 GMT
        Subject: O=Hewlett-Packard Company, OU=Long Lived CodeSigning Certificate, CN=HP UEFI Secure Boot 2013 PK Key
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:cf:12:a7:3b:88:7e:e3:1c:e3:84:5a:4b:a2:0c:
                    10:d2:7c:de:b1:3b:a3:39:e4:51:99:c2:06:6d:1f:
                    33:60:3b:cb:47:56:54:68:2e:76:69:32:4f:4f:4d:
                    81:dc:52:a2:c1:40:a2:03:42:77:90:e3:ec:b0:c5:
                    00:dd:5e:06:91:ee:51:93:8d:d9:d3:93:ed:76:ca:
                    e4:6a:4e:73:5a:07:aa:5a:23:2a:f9:c4:1e:c0:9b:
                    39:41:c9:10:5d:9c:14:69:59:1e:94:a3:27:4c:fd:
                    22:7a:31:62:6d:2d:11:44:04:5a:8d:24:ed:e1:ce:
                    c3:11:8d:4f:f1:46:33:72:c7:f9:18:d2:1b:4f:a5:
                    93:9f:8c:7a:f7:81:a7:cc:b9:80:9b:8e:97:9b:1a:
                    5d:53:a0:57:79:97:d3:58:16:ab:24:71:7f:57:34:
                    3d:a4:6f:2a:08:7a:16:9e:b0:1e:0b:58:2b:b8:2f:
                    8a:1a:35:03:60:da:64:be:27:8c:ef:b4:0f:69:1c:
                    e2:08:56:75:06:fd:60:92:85:ab:29:e8:d5:32:5f:
                    57:88:4e:b7:22:d1:51:af:23:ca:46:90:7d:d2:8d:
                    bc:3e:79:77:79:ed:af:35:87:97:5d:32:2a:70:57:
                    8d:52:78:ae:2b:c2:da:92:d2:2e:93:a6:b7:fd:e8:
                    ae:53
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Basic Constraints: critical
                CA:FALSE
            X509v3 CRL Distribution Points: 

                Full Name:
                  URI:http://onsitecrl.verisign.com/HewlettPackardCompanyDeSPrintingDeviceCSIDTemp/LatestCRL.crl

            X509v3 Key Usage: critical
                Digital Signature
            X509v3 Certificate Policies: 
                Policy: 1.3.6.1.4.1.11.4.4.1.1
                  User Notice:
                    Explicit Text: Hewlett Packard Company, 2, Authority to bind Hewlett-Packard Company does not correspond with use or possession of this certificate. Issued to facilitate communication with HP.

            Authority Information Access: 
                OCSP - URI:http://onsite-ocsp.verisign.com

            X509v3 Subject Key Identifier: 
                ED:98:39:C4:76:7B:3F:85:2E:74:B5:CF:1C:58:9C:A9:06:5C:68:D0
            X509v3 Authority Key Identifier: 
                keyid:B8:A1:0C:BD:06:5F:46:11:E9:80:DB:F7:99:BD:1D:F4:FD:EA:0D:C6

            X509v3 Extended Key Usage: critical
                Code Signing
    Signature Algorithm: sha256WithRSAEncryption
         3a:56:b6:9c:71:e9:0c:54:b0:a2:cb:c2:45:1e:77:33:31:67:
         44:1e:45:4f:86:80:c5:64:9b:4d:17:36:ec:f1:d1:30:78:77:
         22:48:5d:40:e6:79:14:c9:c9:57:70:5e:25:e8:22:f2:5c:72:
         bf:8e:ba:60:b4:e8:88:64:f6:a3:7f:79:a6:74:8e:df:c0:dd:
         ce:86:42:5e:49:8b:ec:32:84:40:d1:e1:50:0a:7c:a5:35:be:
         7f:96:06:76:fc:bc:33:c2:99:71:9e:92:65:92:38:54:19:16:
         85:c7:56:69:d8:c2:d0:06:61:bd:63:df:ee:09:fb:40:ae:8c:
         dd:bb:17:10:14:93:75:0e:d1:b2:51:4e:47:3e:50:49:83:77:
         c8:51:18:c4:c6:bb:e1:51:4f:ba:7b:ef:2e:d6:59:59:42:ae:
         73:09:8c:f4:7b:27:89:c4:6e:34:dc:30:9b:d7:59:03:b7:a3:
         d6:04:34:6a:6e:50:45:fb:02:b2:ea:8c:c3:97:98:0d:0c:45:
         7d:c9:39:84:27:a4:76:93:3f:b5:ad:08:a9:89:66:0b:56:6f:
         47:86:7b:5c:89:1b:98:c5:cd:af:3e:61:57:de:eb:5e:88:8d:
         0f:64:55:3c:16:1e:c5:4d:4a:28:35:a4:23:8c:ef:ed:d8:bf:
         a3:fd:ad:d6
vissol@debian-dev5:~$ mokutil --kek
[key 1]
SHA1 Fingerprint: cb:89:ce:c9:93:2c:47:7c:a9:6e:8d:62:62:6f:cc:47:de:f6:fc:5b
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            3f:30:31:ba:8c:5e:eb:da:e3:04:1b:fa:81:cf:53:7a
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=US, O=Hewlett-Packard Company, CN=Hewlett-Packard Printing Device Infrastructure CA
        Validity
            Not Before: Aug 23 00:00:00 2013 GMT
            Not After : Aug 23 23:59:59 2033 GMT
        Subject: O=Hewlett-Packard Company, OU=Long Lived CodeSigning Certificate, CN=HP UEFI Secure Boot 2013 KEK key
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:a9:93:ea:c7:be:97:7c:ac:8f:31:3e:17:35:7f:
                    68:e8:d8:81:b1:4d:6b:fb:c3:47:4a:09:85:cd:5a:
                    ac:3a:cc:8b:59:fb:a1:0a:67:92:65:6b:8e:ed:af:
                    19:29:b8:05:19:6b:a8:0c:d0:23:d4:5a:60:02:5a:
                    94:e9:b0:df:3c:e2:a7:cf:0d:27:15:59:b9:fe:aa:
                    fc:9f:8b:da:7d:5c:7e:30:88:d8:e9:1d:a2:ea:8d:
                    f4:40:21:13:12:94:ee:be:83:01:86:ab:b9:a4:cf:
                    8a:bd:13:fa:69:06:67:a5:1a:50:84:c6:26:41:13:
                    fb:f4:4b:ba:15:e2:f9:00:62:c7:8a:56:7a:84:b5:
                    ce:f0:b8:f7:10:e2:07:91:8b:69:37:a8:64:11:d9:
                    69:16:51:09:ed:ce:4f:d3:92:75:16:7f:e1:08:9b:
                    7e:67:d3:bc:26:4e:db:bc:72:00:76:2d:45:68:83:
                    f0:68:ad:7e:6d:57:02:b8:15:93:40:94:59:76:f3:
                    b7:b8:7b:fc:00:8a:27:2e:fb:83:28:27:1e:4b:f7:
                    23:84:a2:16:2e:01:45:13:4f:4a:da:2f:3e:8d:65:
                    82:b8:2d:e9:c8:0c:ea:db:36:d4:ac:49:5f:ec:b7:
                    3f:38:1d:e6:18:3e:b6:51:56:e7:c8:5b:ad:28:89:
                    9c:27
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Basic Constraints: critical
                CA:FALSE
            X509v3 CRL Distribution Points: 

                Full Name:
                  URI:http://onsitecrl.verisign.com/HewlettPackardCompanyDeSPrintingDeviceCSIDTemp/LatestCRL.crl

            X509v3 Key Usage: critical
                Digital Signature
            X509v3 Certificate Policies: 
                Policy: 1.3.6.1.4.1.11.4.4.1.1
                  User Notice:
                    Explicit Text: Hewlett Packard Company, 2, Authority to bind Hewlett-Packard Company does not correspond with use or possession of this certificate. Issued to facilitate communication with HP.

            Authority Information Access: 
                OCSP - URI:http://onsite-ocsp.verisign.com

            X509v3 Subject Key Identifier: 
                19:41:BB:C0:8D:B7:02:52:1E:3E:7F:6F:E4:AB:21:FC:6C:D3:BD:51
            X509v3 Authority Key Identifier: 
                keyid:B8:A1:0C:BD:06:5F:46:11:E9:80:DB:F7:99:BD:1D:F4:FD:EA:0D:C6

            X509v3 Extended Key Usage: critical
                Code Signing
    Signature Algorithm: sha256WithRSAEncryption
         5d:e2:2d:a5:7e:c6:5a:d8:ad:65:60:f9:65:8e:18:b9:38:bf:
         38:d6:01:21:e5:0f:fa:3f:fb:fb:a2:9d:fd:c3:93:a1:27:79:
         5a:cd:af:3a:66:2b:20:a0:77:bd:ad:d7:89:b6:00:46:ff:aa:
         da:b7:e9:52:6f:bd:e4:5b:9e:30:78:d1:72:ac:ac:3d:4e:96:
         e6:11:51:48:4a:85:32:c6:7c:0c:f5:28:ba:f1:c2:1a:e9:7f:
         cc:1a:07:db:e1:ab:49:ed:02:73:c1:89:6c:8c:ff:d8:15:61:
         52:94:04:1c:08:59:02:0e:7f:1a:91:ff:60:f3:e5:47:92:67:
         91:4c:1b:e1:1f:f8:60:22:cd:fd:28:19:b1:88:a0:d6:ba:7e:
         74:6c:00:67:0a:07:21:e5:20:e1:ab:cf:df:6d:70:46:1b:17:
         c1:d6:2c:6a:7e:94:d0:10:1a:26:37:a8:e5:0c:c1:dd:6f:a2:
         be:52:58:02:d1:6d:ad:1c:e7:3e:91:f8:2e:cc:e5:83:67:c9:
         5d:eb:9e:27:03:e4:23:56:c6:53:fe:5a:e2:28:79:70:46:f4:
         d9:38:d2:fe:f9:b9:e5:e9:07:62:00:a2:c5:e4:a9:23:98:68:
         1c:93:d1:18:dd:9e:12:69:5c:4d:7e:7f:41:80:8e:04:88:7f:
         e4:cb:da:88

[key 2]
SHA1 Fingerprint: 31:59:0b:fd:89:c9:d7:4e:d0:87:df:ac:66:33:4b:39:31:25:4b:30
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            61:0a:d1:88:00:00:00:00:00:03
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=US, ST=Washington, L=Redmond, O=Microsoft Corporation, CN=Microsoft Corporation Third Party Marketplace Root
        Validity
            Not Before: Jun 24 20:41:29 2011 GMT
            Not After : Jun 24 20:51:29 2026 GMT
        Subject: C=US, ST=Washington, L=Redmond, O=Microsoft Corporation, CN=Microsoft Corporation KEK CA 2011
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:c4:e8:b5:8a:bf:ad:57:26:b0:26:c3:ea:e7:fb:
                    57:7a:44:02:5d:07:0d:da:4a:e5:74:2a:e6:b0:0f:
                    ec:6d:eb:ec:7f:b9:e3:5a:63:32:7c:11:17:4f:0e:
                    e3:0b:a7:38:15:93:8e:c6:f5:e0:84:b1:9a:9b:2c:
                    e7:f5:b7:91:d6:09:e1:e2:c0:04:a8:ac:30:1c:df:
                    48:f3:06:50:9a:64:a7:51:7f:c8:85:4f:8f:20:86:
                    ce:fe:2f:e1:9f:ff:82:c0:ed:e9:cd:ce:f4:53:6a:
                    62:3a:0b:43:b9:e2:25:fd:fe:05:f9:d4:c4:14:ab:
                    11:e2:23:89:8d:70:b7:a4:1d:4d:ec:ae:e5:9c:fa:
                    16:c2:d7:c1:cb:d4:e8:c4:2f:e5:99:ee:24:8b:03:
                    ec:8d:f2:8b:ea:c3:4a:fb:43:11:12:0b:7e:b5:47:
                    92:6c:dc:e6:04:89:eb:f5:33:04:eb:10:01:2a:71:
                    e5:f9:83:13:3c:ff:25:09:2f:68:76:46:ff:ba:4f:
                    be:dc:ad:71:2a:58:aa:fb:0e:d2:79:3d:e4:9b:65:
                    3b:cc:29:2a:9f:fc:72:59:a2:eb:ae:92:ef:f6:35:
                    13:80:c6:02:ec:e4:5f:cc:9d:76:cd:ef:63:92:c1:
                    af:79:40:84:79:87:7f:e3:52:a8:e8:9d:7b:07:69:
                    8f:15
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            1.3.6.1.4.1.311.21.1: 
                ...
            X509v3 Subject Key Identifier: 
                62:FC:43:CD:A0:3E:A4:CB:67:12:D2:5B:D9:55:AC:7B:CC:B6:8A:5F
            1.3.6.1.4.1.311.20.2: 
                .
.S.u.b.C.A
            X509v3 Key Usage: 
                Digital Signature, Certificate Sign, CRL Sign
            X509v3 Basic Constraints: critical
                CA:TRUE
            X509v3 Authority Key Identifier: 
                keyid:45:66:52:43:E1:7E:58:11:BF:D6:4E:9E:23:55:08:3B:3A:22:6A:A8

            X509v3 CRL Distribution Points: 

                Full Name:
                  URI:http://crl.microsoft.com/pki/crl/products/MicCorThiParMarRoo_2010-10-05.crl

            Authority Information Access: 
                CA Issuers - URI:http://www.microsoft.com/pki/certs/MicCorThiParMarRoo_2010-10-05.crt

    Signature Algorithm: sha256WithRSAEncryption
         d4:84:88:f5:14:94:18:02:ca:2a:3c:fb:2a:92:1c:0c:d7:a0:
         d1:f1:e8:52:66:a8:ee:a2:b5:75:7a:90:00:aa:2d:a4:76:5a:
         ea:79:b7:b9:37:6a:51:7b:10:64:f6:e1:64:f2:02:67:be:f7:
         a8:1b:78:bd:ba:ce:88:58:64:0c:d6:57:c8:19:a3:5f:05:d6:
         db:c6:d0:69:ce:48:4b:32:b7:eb:5d:d2:30:f5:c0:f5:b8:ba:
         78:07:a3:2b:fe:9b:db:34:56:84:ec:82:ca:ae:41:25:70:9c:
         6b:e9:fe:90:0f:d7:96:1f:e5:e7:94:1f:b2:2a:0c:8d:4b:ff:
         28:29:10:7b:f7:d7:7c:a5:d1:76:b9:05:c8:79:ed:0f:90:92:
         9c:c2:fe:df:6f:7e:6c:0f:7b:d4:c1:45:dd:34:51:96:39:0f:
         e5:5e:56:d8:18:05:96:f4:07:a6:42:b3:a0:77:fd:08:19:f2:
         71:56:cc:9f:86:23:a4:87:cb:a6:fd:58:7e:d4:69:67:15:91:
         7e:81:f2:7f:13:e5:0d:8b:8a:3c:87:84:eb:e3:ce:bd:43:e5:
         ad:2d:84:93:8e:6a:2b:5a:7c:44:fa:52:aa:81:c8:2d:1c:bb:
         e0:52:df:00:11:f8:9a:3d:c1:60:b0:e1:33:b5:a3:88:d1:65:
         19:0a:1a:e7:ac:7c:a4:c1:82:87:4e:38:b1:2f:0d:c5:14:87:
         6f:fd:8d:2e:bc:39:b6:e7:e6:c3:e0:e4:cd:27:84:ef:94:42:
         ef:29:8b:90:46:41:3b:81:1b:67:d8:f9:43:59:65:cb:0d:bc:
         fd:00:92:4f:f4:75:3b:a7:a9:24:fc:50:41:40:79:e0:2d:4f:
         0a:6a:27:76:6e:52:ed:96:69:7b:af:0f:f7:87:05:d0:45:c2:
         ad:53:14:81:1f:fb:30:04:aa:37:36:61:da:4a:69:1b:34:d8:
         68:ed:d6:02:cf:6c:94:0c:d3:cf:6c:22:79:ad:b1:f0:bc:03:
         a2:46:60:a9:c4:07:c2:21:82:f1:fd:f2:e8:79:32:60:bf:d8:
         ac:a5:22:14:4b:ca:c1:d8:4b:eb:7d:3f:57:35:b2:e6:4f:75:
         b4:b0:60:03:22:53:ae:91:79:1d:d6:9b:41:1f:15:86:54:70:
         b2:de:0d:35:0f:7c:b0:34:72:ba:97:60:3b:f0:79:eb:a2:b2:
         1c:5d:a2:16:b8:87:c5:e9:1b:f6:b5:97:25:6f:38:9f:e3:91:
         fa:8a:79:98:c3:69:0e:b7:a3:1c:20:05:97:f8:ca:14:ae:00:
         d7:c4:f3:c0:14:10:75:6b:34:a0:1b:b5:99:60:f3:5c:b0:c5:
         57:4e:36:d2:32:84:bf:9e
vissol@debian-dev5:~$ mokutil --db
[key 1]
SHA1 Fingerprint: d9:e4:bd:47:48:c1:2b:42:bc:6a:ba:6c:d3:0a:3d:0c:c6:f3:66:71
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            56:74:a7:03:ef:39:09:10:8b:1f:47:53:68:73:6d:6d
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=US, O=Hewlett-Packard Company, CN=Hewlett-Packard Printing Device Infrastructure CA
        Validity
            Not Before: Aug 23 00:00:00 2013 GMT
            Not After : Aug 23 23:59:59 2033 GMT
        Subject: O=Hewlett-Packard Company, OU=Long Lived CodeSigning Certificate, CN=HP UEFI Secure Boot 2013 DB key
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:c9:47:bf:88:64:a6:16:59:57:6f:6c:7f:0c:ca:
                    08:df:97:82:a1:3b:ef:36:02:15:43:9b:ea:9a:ab:
                    e5:4d:bc:fb:b4:b4:4f:85:89:e4:a7:e5:25:d4:e6:
                    9b:36:4b:99:8e:2f:01:7d:e1:90:d8:8a:39:61:8e:
                    90:66:9f:73:d3:f3:38:2e:68:fd:e6:18:db:f3:3e:
                    ac:84:ec:64:1c:e9:07:a3:f2:e7:52:6b:28:75:6f:
                    34:79:ab:24:3f:a7:cc:fd:fc:3a:32:71:fc:b3:22:
                    11:18:60:76:eb:31:a2:28:8d:72:f3:3c:af:4d:95:
                    01:bd:a2:f0:b1:43:6a:5d:14:33:3b:11:72:8c:69:
                    71:ab:b4:a3:1d:c7:33:64:86:8a:7f:e1:41:33:d8:
                    19:15:9a:71:14:df:ba:76:10:c9:8f:03:fd:5c:3a:
                    4c:c5:93:e5:a9:b6:40:e0:03:7b:75:47:7a:3a:3e:
                    3a:51:af:d3:43:2a:2b:ca:6a:cf:d0:3c:44:1e:e9:
                    bf:c9:af:a6:b3:d0:c4:c0:f3:18:b9:9c:a6:6b:6e:
                    3c:57:4e:82:f6:6a:44:32:65:da:38:52:f4:5b:9f:
                    bc:b1:22:1a:98:f3:f0:e1:89:a5:a1:8b:a4:9a:21:
                    31:2a:89:b5:eb:f3:b1:9b:44:93:d5:02:b5:a5:2b:
                    16:8b
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Basic Constraints: critical
                CA:FALSE
            X509v3 CRL Distribution Points: 

                Full Name:
                  URI:http://onsitecrl.verisign.com/HewlettPackardCompanyDeSPrintingDeviceCSIDTemp/LatestCRL.crl

            X509v3 Key Usage: critical
                Digital Signature
            X509v3 Certificate Policies: 
                Policy: 1.3.6.1.4.1.11.4.4.1.1
                  User Notice:
                    Explicit Text: Hewlett Packard Company, 2, Authority to bind Hewlett-Packard Company does not correspond with use or possession of this certificate. Issued to facilitate communication with HP.

            Authority Information Access: 
                OCSP - URI:http://onsite-ocsp.verisign.com

            X509v3 Subject Key Identifier: 
                1D:7C:F2:C2:B9:26:73:F6:9C:8E:E1:EC:70:63:96:7A:B9:B6:2B:EC
            X509v3 Authority Key Identifier: 
                keyid:B8:A1:0C:BD:06:5F:46:11:E9:80:DB:F7:99:BD:1D:F4:FD:EA:0D:C6

            X509v3 Extended Key Usage: critical
                Code Signing
    Signature Algorithm: sha256WithRSAEncryption
         45:cf:1e:81:bc:12:42:ba:b3:42:df:52:10:e2:29:6b:2e:69:
         66:33:82:f4:a4:47:ca:73:78:54:03:e7:fe:ed:e5:87:e7:6d:
         b9:04:eb:08:ff:21:3a:32:c3:9c:42:04:52:2a:3f:97:f0:2b:
         d5:bc:93:7b:41:3e:39:e9:27:67:79:f2:da:3a:41:81:9a:99:
         9d:a1:79:e1:c6:94:6b:f0:98:1d:ed:db:94:44:9b:d2:3c:cb:
         c8:d3:35:47:d7:a8:96:c7:d3:8d:3f:a4:e9:6d:34:ec:a9:6c:
         68:58:23:9f:27:6a:36:e6:e2:9a:98:e1:92:a6:b2:b0:6e:29:
         ec:93:9d:d2:35:59:a6:06:ab:83:be:cf:c3:7e:5d:f8:12:d9:
         ba:67:76:7a:99:e1:18:05:51:fa:34:85:eb:1f:85:5f:19:aa:
         32:bd:32:41:98:72:22:69:24:41:22:cb:ac:ae:73:17:17:5a:
         59:28:d7:29:f8:a7:fd:54:8e:cf:be:14:eb:46:1e:82:8d:77:
         8d:93:cd:93:06:9b:56:da:b2:b2:4e:c9:96:88:6d:97:04:72:
         88:e3:f7:a8:1e:a0:37:af:dc:6e:05:ae:e8:c8:50:28:5a:41:
         a3:ea:4a:ed:7e:0c:ad:fc:6e:80:eb:c9:36:54:97:a7:54:61:
         0c:34:60:40

[key 2]
SHA1 Fingerprint: 58:0a:6f:4c:c4:e4:b6:69:b9:eb:dc:1b:2b:3e:08:7b:80:d0:67:8d
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            61:07:76:56:00:00:00:00:00:08
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=US, ST=Washington, L=Redmond, O=Microsoft Corporation, CN=Microsoft Root Certificate Authority 2010
        Validity
            Not Before: Oct 19 18:41:42 2011 GMT
            Not After : Oct 19 18:51:42 2026 GMT
        Subject: C=US, ST=Washington, L=Redmond, O=Microsoft Corporation, CN=Microsoft Windows Production PCA 2011
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:dd:0c:bb:a2:e4:2e:09:e3:e7:c5:f7:96:69:bc:
                    00:21:bd:69:33:33:ef:ad:04:cb:54:80:ee:06:83:
                    bb:c5:20:84:d9:f7:d2:8b:f3:38:b0:ab:a4:ad:2d:
                    7c:62:79:05:ff:e3:4a:3f:04:35:20:70:e3:c4:e7:
                    6b:e0:9c:c0:36:75:e9:8a:31:dd:8d:70:e5:dc:37:
                    b5:74:46:96:28:5b:87:60:23:2c:bf:dc:47:a5:67:
                    f7:51:27:9e:72:eb:07:a6:c9:b9:1e:3b:53:35:7c:
                    e5:d3:ec:27:b9:87:1c:fe:b9:c9:23:09:6f:a8:46:
                    91:c1:6e:96:3c:41:d3:cb:a3:3f:5d:02:6a:4d:ec:
                    69:1f:25:28:5c:36:ff:fd:43:15:0a:94:e0:19:b4:
                    cf:df:c2:12:e2:c2:5b:27:ee:27:78:30:8b:5b:2a:
                    09:6b:22:89:53:60:16:2c:c0:68:1d:53:ba:ec:49:
                    f3:9d:61:8c:85:68:09:73:44:5d:7d:a2:54:2b:dd:
                    79:f7:15:cf:35:5d:6c:1c:2b:5c:ce:bc:9c:23:8b:
                    6f:6e:b5:26:d9:36:13:c3:4f:d6:27:ae:b9:32:3b:
                    41:92:2c:e1:c7:cd:77:e8:aa:54:4e:f7:5c:0b:04:
                    87:65:b4:43:18:a8:b2:e0:6d:19:77:ec:5a:24:fa:
                    48:03
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            1.3.6.1.4.1.311.21.1: 
                ...
            X509v3 Subject Key Identifier: 
                A9:29:02:39:8E:16:C4:97:78:CD:90:F9:9E:4F:9A:E1:7C:55:AF:53
            1.3.6.1.4.1.311.20.2: 
                .
.S.u.b.C.A
            X509v3 Key Usage: 
                Digital Signature, Certificate Sign, CRL Sign
            X509v3 Basic Constraints: critical
                CA:TRUE
            X509v3 Authority Key Identifier: 
                keyid:D5:F6:56:CB:8F:E8:A2:5C:62:68:D1:3D:94:90:5B:D7:CE:9A:18:C4

            X509v3 CRL Distribution Points: 

                Full Name:
                  URI:http://crl.microsoft.com/pki/crl/products/MicRooCerAut_2010-06-23.crl

            Authority Information Access: 
                CA Issuers - URI:http://www.microsoft.com/pki/certs/MicRooCerAut_2010-06-23.crt

    Signature Algorithm: sha256WithRSAEncryption
         14:fc:7c:71:51:a5:79:c2:6e:b2:ef:39:3e:bc:3c:52:0f:6e:
         2b:3f:10:13:73:fe:a8:68:d0:48:a6:34:4d:8a:96:05:26:ee:
         31:46:90:61:79:d6:ff:38:2e:45:6b:f4:c0:e5:28:b8:da:1d:
         8f:8a:db:09:d7:1a:c7:4c:0a:36:66:6a:8c:ec:1b:d7:04:90:
         a8:18:17:a4:9b:b9:e2:40:32:36:76:c4:c1:5a:c6:bf:e4:04:
         c0:ea:16:d3:ac:c3:68:ef:62:ac:dd:54:6c:50:30:58:a6:eb:
         7c:fe:94:a7:4e:8e:f4:ec:7c:86:73:57:c2:52:21:73:34:5a:
         f3:a3:8a:56:c8:04:da:07:09:ed:f8:8b:e3:ce:f4:7e:8e:ae:
         f0:f6:0b:8a:08:fb:3f:c9:1d:72:7f:53:b8:eb:be:63:e0:e3:
         3d:31:65:b0:81:e5:f2:ac:cd:16:a4:9f:3d:a8:b1:9b:c2:42:
         d0:90:84:5f:54:1d:ff:89:ea:ba:1d:47:90:6f:b0:73:4e:41:
         9f:40:9f:5f:e5:a1:2a:b2:11:91:73:8a:21:28:f0:ce:de:73:
         39:5f:3e:ab:5c:60:ec:df:03:10:a8:d3:09:e9:f4:f6:96:85:
         b6:7f:51:88:66:47:19:8d:a2:b0:12:3d:81:2a:68:05:77:bb:
         91:4c:62:7b:b6:c1:07:c7:ba:7a:87:34:03:0e:4b:62:7a:99:
         e9:ca:fc:ce:4a:37:c9:2d:a4:57:7c:1c:fe:3d:dc:b8:0f:5a:
         fa:d6:c4:b3:02:85:02:3a:ea:b3:d9:6e:e4:69:21:37:de:81:
         d1:f6:75:19:05:67:d3:93:57:5e:29:1b:39:c8:ee:2d:e1:cd:
         e4:45:73:5b:d0:d2:ce:7a:ab:16:19:82:46:58:d0:5e:9d:81:
         b3:67:af:6c:35:f2:bc:e5:3f:24:e2:35:a2:0a:75:06:f6:18:
         56:99:d4:78:2c:d1:05:1b:eb:d0:88:01:9d:aa:10:f1:05:df:
         ba:7e:2c:63:b7:06:9b:23:21:c4:f9:78:6c:e2:58:17:06:36:
         2b:91:12:03:cc:a4:d9:f2:2d:ba:f9:94:9d:40:ed:18:45:f1:
         ce:8a:5c:6b:3e:ab:03:d3:70:18:2a:0a:6a:e0:5f:47:d1:d5:
         63:0a:32:f2:af:d7:36:1f:2a:70:5a:e5:42:59:08:71:4b:57:
         ba:7e:83:81:f0:21:3c:f4:1c:c1:c5:b9:90:93:0e:88:45:93:
         86:e9:b1:20:99:be:98:cb:c5:95:a4:5d:62:d6:a0:63:08:20:
         bd:75:10:77:7d:3d:f3:45:b9:9f:97:9f:cb:57:80:6f:33:a9:
         04:cf:77:a4:62:1c:59:7e

[key 3]
SHA1 Fingerprint: 46:de:f6:3b:5c:e6:1c:f8:ba:0d:e2:e6:63:9c:10:19:d0:ed:14:f3
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            61:08:d3:c4:00:00:00:00:00:04
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=US, ST=Washington, L=Redmond, O=Microsoft Corporation, CN=Microsoft Corporation Third Party Marketplace Root
        Validity
            Not Before: Jun 27 21:22:45 2011 GMT
            Not After : Jun 27 21:32:45 2026 GMT
        Subject: C=US, ST=Washington, L=Redmond, O=Microsoft Corporation, CN=Microsoft Corporation UEFI CA 2011
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:a5:08:6c:4c:c7:45:09:6a:4b:0c:a4:c0:87:7f:
                    06:75:0c:43:01:54:64:e0:16:7f:07:ed:92:7d:0b:
                    b2:73:bf:0c:0a:c6:4a:45:61:a0:c5:16:2d:96:d3:
                    f5:2b:a0:fb:4d:49:9b:41:80:90:3c:b9:54:fd:e6:
                    bc:d1:9d:c4:a4:18:8a:7f:41:8a:5c:59:83:68:32:
                    bb:8c:47:c9:ee:71:bc:21:4f:9a:8a:7c:ff:44:3f:
                    8d:8f:32:b2:26:48:ae:75:b5:ee:c9:4c:1e:4a:19:
                    7e:e4:82:9a:1d:78:77:4d:0c:b0:bd:f6:0f:d3:16:
                    d3:bc:fa:2b:a5:51:38:5d:f5:fb:ba:db:78:02:db:
                    ff:ec:0a:1b:96:d5:83:b8:19:13:e9:b6:c0:7b:40:
                    7b:e1:1f:28:27:c9:fa:ef:56:5e:1c:e6:7e:94:7e:
                    c0:f0:44:b2:79:39:e5:da:b2:62:8b:4d:bf:38:70:
                    e2:68:24:14:c9:33:a4:08:37:d5:58:69:5e:d3:7c:
                    ed:c1:04:53:08:e7:4e:b0:2a:87:63:08:61:6f:63:
                    15:59:ea:b2:2b:79:d7:0c:61:67:8a:5b:fd:5e:ad:
                    87:7f:ba:86:67:4f:71:58:12:22:04:22:22:ce:8b:
                    ef:54:71:00:ce:50:35:58:76:95:08:ee:6a:b1:a2:
                    01:d5
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            1.3.6.1.4.1.311.21.1: 
                .....
            1.3.6.1.4.1.311.21.2: 
                ....k..wSJ.%7.N.&{. p.
            X509v3 Subject Key Identifier: 
                13:AD:BF:43:09:BD:82:70:9C:8C:D5:4F:31:6E:D5:22:98:8A:1B:D4
            1.3.6.1.4.1.311.20.2: 
                .
.S.u.b.C.A
            X509v3 Key Usage: 
                Digital Signature, Certificate Sign, CRL Sign
            X509v3 Basic Constraints: critical
                CA:TRUE
            X509v3 Authority Key Identifier: 
                keyid:45:66:52:43:E1:7E:58:11:BF:D6:4E:9E:23:55:08:3B:3A:22:6A:A8

            X509v3 CRL Distribution Points: 

                Full Name:
                  URI:http://crl.microsoft.com/pki/crl/products/MicCorThiParMarRoo_2010-10-05.crl

            Authority Information Access: 
                CA Issuers - URI:http://www.microsoft.com/pki/certs/MicCorThiParMarRoo_2010-10-05.crt

    Signature Algorithm: sha256WithRSAEncryption
         35:08:42:ff:30:cc:ce:f7:76:0c:ad:10:68:58:35:29:46:32:
         76:27:7c:ef:12:41:27:42:1b:4a:aa:6d:81:38:48:59:13:55:
         f3:e9:58:34:a6:16:0b:82:aa:5d:ad:82:da:80:83:41:06:8f:
         b4:1d:f2:03:b9:f3:1a:5d:1b:f1:50:90:f9:b3:55:84:42:28:
         1c:20:bd:b2:ae:51:14:c5:c0:ac:97:95:21:1c:90:db:0f:fc:
         77:9e:95:73:91:88:ca:bd:bd:52:b9:05:50:0d:df:57:9e:a0:
         61:ed:0d:e5:6d:25:d9:40:0f:17:40:c8:ce:a3:4a:c2:4d:af:
         9a:12:1d:08:54:8f:bd:c7:bc:b9:2b:3d:49:2b:1f:32:fc:6a:
         21:69:4f:9b:c8:7e:42:34:fc:36:06:17:8b:8f:20:40:c0:b3:
         9a:25:75:27:cd:c9:03:a3:f6:5d:d1:e7:36:54:7a:b9:50:b5:
         d3:12:d1:07:bf:bb:74:df:dc:1e:8f:80:d5:ed:18:f4:2f:14:
         16:6b:2f:de:66:8c:b0:23:e5:c7:84:d8:ed:ea:c1:33:82:ad:
         56:4b:18:2d:f1:68:95:07:cd:cf:f0:72:f0:ae:bb:dd:86:85:
         98:2c:21:4c:33:2b:f0:0f:4a:f0:68:87:b5:92:55:32:75:a1:
         6a:82:6a:3c:a3:25:11:a4:ed:ad:d7:04:ae:cb:d8:40:59:a0:
         84:d1:95:4c:62:91:22:1a:74:1d:8c:3d:47:0e:44:a6:e4:b0:
         9b:34:35:b1:fa:b6:53:a8:2c:81:ec:a4:05:71:c8:9d:b8:ba:
         e8:1b:44:66:e4:47:54:0e:8e:56:7f:b3:9f:16:98:b2:86:d0:
         68:3e:90:23:b5:2f:5e:8f:50:85:8d:c6:8d:82:5f:41:a1:f4:
         2e:0d:e0:99:d2:6c:75:e4:b6:69:b5:21:86:fa:07:d1:f6:e2:
         4d:d1:da:ad:2c:77:53:1e:25:32:37:c7:6c:52:72:95:86:b0:
         f1:35:61:6a:19:f5:b2:3b:81:50:56:a6:32:2d:fe:a2:89:f9:
         42:86:27:18:55:a1:82:ca:5a:9b:f8:30:98:54:14:a6:47:96:
         25:2f:c8:26:e4:41:94:1a:5c:02:3f:e5:96:e3:85:5b:3c:3e:
         3f:bb:47:16:72:55:e2:25:22:b1:d9:7b:e7:03:06:2a:a3:f7:
         1e:90:46:c3:00:0d:d6:19:89:e3:0e:35:27:62:03:71:15:a6:
         ef:d0:27:a0:a0:59:37:60:f8:38:94:b8:e0:78:70:f8:ba:4c:
         86:87:94:f6:e0:ae:02:45:ee:65:c2:b6:a3:7e:69:16:75:07:
         92:9b:f5:a6:bc:59:83:58
vissol@debian-dev5:~$ mokutil --dbx
[key 1]
  [SHA-256]
  6e340b9cffb37a989ca544e6bb780a2c78901d3fb33738768511a30617afa01d

[key 2]
  [SHA-256]
  80b4d96931bf0d02fd91a61e19d14f1da452e66db2408ca8604d411f92659f0a
  f52f83a3fa9cfbd6920f722824dbe4034534d25b8507246b3b957dac6e1bce7a
  c5d9d8a186e2c82d09afaa2a6f7f2e73870d3e64f72c4e08ef67796a840f0fbd
  363384d14d1f2e0b7815626484c459ad57a318ef4396266048d058c5a19bbf76
  1aec84b84b6c65a51220a9be7181965230210d62d6d33c48999c6b295a2b0a06
  e6ca68e94146629af03f69c2f86e6bef62f930b37c6fbcc878b78df98c0334e5
  c3a99a460da464a057c3586d83cef5f4ae08b7103979ed8932742df0ed530c66
  58fb941aef95a25943b3fb5f2510a0df3fe44c58c95e0ab80487297568ab9771
  5391c3a2fb112102a6aa1edc25ae77e19f5d6f09cd09eeb2509922bfcd5992ea
  d626157e1d6a718bc124ab8da27cbb65072ca03a7b6b257dbdcbbd60f65ef3d1
  d063ec28f67eba53f1642dbf7dff33c6a32add869f6013fe162e2c32f1cbe56d
  29c6eb52b43c3aa18b2cd8ed6ea8607cef3cfae1bafe1165755cf2e614844a44
  90fbe70e69d633408d3e170c6832dbb2d209e0272527dfb63d49d29572a6f44c
vissol@debian-dev5:~$ 
```

# Auditd

## Commands

For starting auditd:

```bash
*$* service auditd start
```

For stopping auditd:

```bash
*$* service auditd stop
```

For restarting auditd:

```bash
*$* service auditd restart
```

For fetching auditd status:

```bash
*$* service auditd status
```

For conditional restarting auditd:

```bash
*$* service auditd condrestart
```

For reload auditd service:

```bash
*$* service auditd reload
```

For rotating auditd logs:

```bash
*$* service auditd rotate
```

For checking auditd configurations output:

```bash
*$* chkconfig --list auditd
```

## Events

Auditd catches the following events (list far from full):

- Timestamp and event information such as type and outcome of an event.
- Event triggered along with the user who triggered it.
- Changes to audit configuration files.
- Access attempts for audit log files.
- All authentication events with the authenticated users such as ssh, etc.
- Changes to sensitive files or databases such as passwords in /etc/passwd.
- Incoming and outgoing information from and to the system.

## Auxiliary tools

- `auditctl`: utility for managing the auditd daemon; returns 
  information on the audit subsystem’s current status and can be used to 
  add and delete rules
- `autrace`: utility for auditing events caused by processes (the same as strace)
- `ausearch`: utility for searching for events in log files
- `aureport`: utility for generating reports on the audit system

# Firejail configuration

The `/etc/firejail/firejail.config` must be modified to add more security. see here the template configuration for Debian 11. We have uncommented all the necessary parameters. 

```bash
# This is Firejail system-wide configuration file. The file contains
# keyword-argument pairs, one per line. Most features are enabled by default.
# Use 'yes' or 'no' as configuration values.

# Enable AppArmor functionality, default enabled.
apparmor yes

# Number of ARP probes sent when assigning an IP address for --net option,
# default 2. This is a partial implementation of RFC 5227. A 0.5 seconds
# timeout is implemented for each probe. Increase this number to 4 if your
# local layer 2 network uses RSTP (IEEE 802.1w). Permitted values are
# between 1 and 30.
# arp-probes 2

# Enable or disable bind support, default enabled.
# bind yes

# Allow (DRM) execution in browsers, default disabled.
browser-allow-drm yes

# Disable U2F in browsers, default enabled.
# browser-disable-u2f yes

# Enable or disable cgroup support, default enabled.
#cgroup yes

# Enable or disable chroot support, default enabled.
# chroot yes

# Enable or disable dbus handling, default enabled.
# dbus yes

# Disable /mnt, /media, /run/mount and /run/media access. By default access
# to these directories is enabled. Unlike --disable-mnt profile option this
# cannot be overridden by --noblacklist or --ignore.
disable-mnt yes

# Enable or disable file transfer support, default enabled.
# file-transfer yes

# Enable Firejail green prompt in terminal, default disabled
# firejail-prompt no

# Force use of nonewprivs.  This mitigates the possibility of
# a user abusing firejail's features to trick a privileged (suid
# or file capabilities) process into loading code or configuration
# that is partially under their control.  Default disabled.
force-nonewprivs yes

# Allow sandbox joining as a regular user, default enabled.
# root user can always join sandboxes.
# join yes

# Timeout when joining a sandbox, default five seconds. It is not
# possible to join a sandbox while it is still starting up. Wait up
# to the specified period of time to allow sandbox setup to finish.
# join-timeout 5

# Enable or disable sandbox name change, default enabled.
# name-change yes

# Change default netfilter configuration. When using --netfilter option without
# a file argument, the default filter is hardcoded (see man 1 firejail). This
# configuration entry allows the user to change the default by specifying
# a file containing the filter configuration. The filter file format is the
# format of  iptables-save  and iptable-restore commands. Example:
# netfilter-default /etc/iptables.iptables.rules

# Enable or disable networking features, default enabled.
#network yes

# Enable or disable overlayfs features, default enabled.
#overlayfs yes

# Set the limit for file copy in several --private-* options. The size is set
# in megabytes. By default we allow up to 500MB.
# Note: the files are copied in RAM.
# file-copy-limit 500

# Enable or disable private-bin feature, default enabled.
#private-bin yes

# Remove /usr/local directories from private-bin list, default disabled.
# private-bin-no-local no

# Enable or disable private-cache feature, default enabled
# private-cache yes

# Enable or disable private-etc feature, default enabled.
#private-etc yes

# Enable or disable private-home feature, default enabled
#private-home yes

# Enable or disable private-lib feature, default enabled
#private-lib yes

# Enable or disable private-opt feature, default enabled.
#private-opt yes

# Enable or disable private-srv feature, default enabled.
# private-srv yes

# Enable --quiet as default every time the sandbox is started. Default disabled.
# quiet-by-default no

# Enable or disable restricted network support, default disabled. If enabled,
# networking features should also be enabled (network yes).
# Restricted networking grants access to --interface, --net=ethXXX and
# --netfilter only to root user. Regular users are only allowed --net=none.
restricted-network no

# Enable or disable seccomp support, default enabled.
seccomp yes

# Add rules to the default seccomp filter. Same syntax as for --seccomp=
# None by default; this is an example.
# seccomp-filter-add !chroot,kcmp,mincore

# Seccomp error action, kill, log or errno (EPERM, ENOSYS etc)
# seccomp-error-action EPERM

# Enable or disable user namespace support, default enabled.
# userns yes

# Enable or disable whitelisting support, default enabled.
# whitelist yes

# Disable whitelist top level directories, in addition to those
# that are disabled out of the box. None by default; this is an example.
# whitelist-disable-topdir /etc,/usr/etc

# Enable or disable X11 sandboxing support, default enabled.
# x11 yes

# Xephyr command extra parameters. None by default; these are examples.
# xephyr-extra-params -keybd ephyr,,,xkbmodel=evdev
# xephyr-extra-params -grayscale

# Screen size for --x11=xephyr, default 800x600. Run /usr/bin/xrandr for
# a full list of resolutions available on your specific setup.
# xephyr-screen 640x480
# xephyr-screen 800x600
# xephyr-screen 1024x768
# xephyr-screen 1280x1024

# Firejail window title in Xephyr, default enabled.
# xephyr-window-title yes

# Enable this option if you have a version of Xpra that supports --attach switch
# for start command, default disabled.
# xpra-attach no

# Xpra server command extra parameters. None by default; this is an example.
# xpra-extra-params --dpi 96

# Screen size for --x11=xvfb, default 800x600x24.  The third dimension is
# color depth; use 24 unless you know exactly what you're doing.
# xvfb-screen 640x480x24
# xvfb-screen 800x600x24
# xvfb-screen 1024x768x24
# xvfb-screen 1280x1024x24

# Xvfb command extra parameters.  None by default; this is an example.
# xvfb-extra-params -pixdepths 8 24 32
```

# Emails

We recommend using ProtonMail which is a solution designed by Proton Technologies AG, in Geneva, Switzerland. You can have 500Mo space for free.

This is a Zero-access enryption solution (See https://protonmail.com/blog/zero-access-encryption/) with a good UX, available on PC and mobile.

Creating a free account is very easy:

- Go to https://protonmail.com/
- Choose Sign up and select Free Plan
- fill the form

![](pictures/Debian_11_secure/protonmail.png)

## Free 2FA authentication

If you want to secure more your access, get FreeOTP on your Smartphone 

<img src="pictures/Debian_11_secure/freeotp.jpg" style="zoom:50%;" />

Go to your Protonmail account and Settings -> Go to settings -> Account -> Password & security -> Passwords and enable Two-factor authentication.

![](pictures/Debian_11_secure/protonmail_2FA_1.png)

Scan the QR Code, get the Code generated by FreeOTP and confirm the password and the code. You are now ready to use 2FA!

Now, when you tip your credential to your Protonmail account, you need your FreeOTP app to generate your second factor of authentication:

![](pictures/Debian_11_secure/protonmail_2FA_2.png)

## Webmail UI

![](pictures/Debian_11_secure/protonmail_ui.png)

## Mobile UI

<img src="pictures/Debian_11_secure/protonmail1.jpg" style="zoom:50%;" /><img src="pictures/Debian_11_secure/protonmail2.jpg" style="zoom:50%;" />

# Web layers

Here are the layers composing the Web:

![](pictures/Debian_11_secure/the_web.png)

**The Surface web** (visible web) is the portion of the web available to the general public and indexed in the standard web search engines such as Google, Bing and Yahoo.

**The deep web** is made up of content that search engines such as Google do not index. Such data includes medical records, financial information, research papers, private forums and networks, and other content.

**The dark web** is web content that exists on darknets, which are overlay networks on the internet that require specialized software, configurations and authorization to access. Perhaps the best-known tool used to access the dark web is the Tor browser. (More about that later.)

Advices to navigate into the Dark Web:

- Use VPN

- Use Tor Browser

**Extra security measurements**:

Even though you have your VPN and Tor downloaded, you will need to 
take a few extra steps if you want to make sure your experience is as 
secure as possible.

- First of all, remember that many sites on the dark web don’t have 
  SSL enabled which means they can’t verify their own identity or encrypt 
  traffic between servers and clients – this makes it easy for hackers to 
  intercept communications. For example, most credit card numbers are not 
  stored by encryption but with plain text which means anyone can steal 
  them from an insecure network!
- Make sure any website has an “s” added after “onion” in its address 
  before entering anything sensitive into it such as passwords or bank 
  details! If there’s no “s” on the end then assume the site isn’t safe 
  and leave immediately without using it at all!
- Turn off your device’s location setting. Your IP address and your device can be used to determine your location.
- Cover your webcam and microphone when not in use. Hackers have been 
  known to gain access to people’s devices by using their webcam and 
  microphone without their knowledge!
- Close all over browsers and password managers.
- When you are done browsing (or even while still on the dark web) 
  make sure to wipe your browser history, clear cookies and delete any 
  other traces of activity! If possible always use an operating system 
  that supports full disk encryption like Linux because otherwise, it will
   be easy for someone to access everything on your computer if they steal
   or hack it.
- Have a good and reliable antivirus program
