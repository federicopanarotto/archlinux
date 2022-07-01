## INSTALLATION GUIDE

Documentation about to install Archlinux  
``DOCUMENTATION``: https://wiki.archlinux.org/title/Installation_guide  

Installer is a text-based user interface > Arch Installation Framework (AIF)  
Download the installation image from the official repository

##
#### Verify signature 
It is recommended to verify the image signature before use but you can skip this step

	$ pacman-key -v archlinux-version-x86_64.iso.sig

##
#### Preparate an installation medium
The installation image can be supplied to the target via USB or optical disc so download the iso and flash it to make the live

##
#### Boot the live environment
Put the installation medium into your pc and wait the startup  
Select archlinux install medium and press enter after the boot of the pc  

> Installation image uses systemd-boot x64, GRUB UEFI and syslinux for bios booting
> https://wiki.archlinux.org/title/Kernel_parameters#Configuration

Nano and vim are avaible

##
#### Set the console keyboard layout
The default console keymap is US  

The available layout are visible with these command

	$ ls /usr/share/kbd/keymaps/**/*.map.gz

You can change the layout with this command

	$ loadkeys it

##
#### Verify the boot mode
To verify the boot mode list the efivars directory

	$ ls /sys/firmware/efi/efivars

If there aren't error the system is booted in UEFI mode  
If the directory doesn't exist the system may be booted in BIOS mode

##
#### Connect to internet
If you are connected with wire you can skip this section  

You have to choose your the interface card

	$ ip link

Use **iwctl** to authenticate to the wireless network  
``DOCUMENTATION``: https://wiki.archlinux.org/title/Iwd#iwctl

Check the status of the connection by pinging archlinux site

	$ ping archlinux.org

##
#### Update the system clock
Verify that the time clock is accurate: 

	$ timedatectl set-ntp true

To check the service status use timedatectl status

##
#### Partition the disk
Disk are assigned to a block device such as `/dev/sda`  
This list our block of disk and we can see the partitions that there are  
You can use fdisk

	$ fdisk -l
	

Are required the following partition:  

- One partition for root directory /
- For booting in UEFI mode: EFI system partition
- One for SWAP space

Read documentation for use fdisk to make the partitions  
``DOCUMENTATION``: https://wiki.archlinux.org/title/Fdisk

This tutorial use GPT partition  
Create a partition table:  

	$ cfdisk /dev/sda

We are goinf to use cfdisk. It is a graphical program to make the partitions  
It opens a GUI and we can see the disks that there are in the system  
Use the arrows to select the options   

Press on **NEW** enter and specify the space for each partition  
Select the type of the partion selecting the **TYPE** buttom

- EFI SYSTEM > 550M B
- LINUX SWAP > 4GB
- LINUX FILESYSTEM > Free Space

Swap partition is normally your RAM * 2 but you can select your favourite dimension as well

When you done press **WRITE** to create all partitions
Confirm typing yes and go ahead  
Then you can quit by press **QUIT**

Using fdisk -l now you can see the new partion table

> /dev/sda1 EFI SYSTEM  
> /dev/sda2 SWAP  
> /dev/sda3 ROOT  

##
#### Format the partitions
Once the partitions have been created each newly created partition must be formatted with an appropriate file system  
``DOCUMENTATION``: https://wiki.archlinux.org/title/File_systems#Create_a_file_system

To create an ext4 file system run:

	$ mkfs.ext4 /dev/root_partition

To initialize the swap use:

	$ mkswap /dev/swap_partition

To format the EFI partition use this command:

	$ mkfs.fat -F 32 /dev/efi_system_partition

##
#### Mount the file system
By mounting a partition you make it accessible to the operative system    
On unix-like systems a filesystem can be mounted at any directory  

Use command mount to mount the root filesystem

	$ mount /dev/sda3 /mnt

We need to create a new directory where to mount the boot and then mount the EFI filesystem

	$ mkdir /mnt/boot/efi
	$ mount /dev/sda1 /mnt/boot/efi

If you are created swap partition you need to put it on with this command:

	$ swapon /dev/sda2

You need to genereate the basic partition table and mounting points with genfstab but we will use later

##
#### Select the mirrors
Packages to be installed must be downloaded from mirror servers  
They are defined in `/etc/pacman.d/mirrorlist`  

Reflector is a program that updates the mirror list by choosing 20 most recently syncronized HTTPS mirrors and sorting them by downlaod rate  

This command check the fastest mirrors and save them in the pacman configuration file

	$ reflector --country Italy --sort rate -l 5 --save /etc/pacman.d/mirrorlist

To view the fastest mirror run a cat of the file

	$ cat /etc/pacman.d/mirrorlist

##
#### Install essential packages
Use Pacstrap script to install the base package  
We will install **Linux Kernel** and firmware for common hardware  

Run this command:

	$ pacstrap /mnt base base-devel linux linux-firmware nano vim

The base package does not provide tools for developing so we add base-devel
We need to add a text editor so we will install nano too  
To install other package use pacman when the installation is finished in the chroot system

##
#### Fstab
Generate an fstab file to mantain the partition and mount configuration at system startup:

	$ genfstab -U /mnt >> /mnt/etc/fstab

Check the result in the fstab file

	$ cat /mnt/etc/fstab

##
#### Chroot
Chroot stays for change root. It Change the root in the new system just created  

	$ arch-chroot /mnt

##
#### Time zone
Set the time zone to your country

	$ ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime

Run hwclock to generate `/etc/adjtime`:

	$ hwclock --systohc

This command assumes the hardware clock is set to UTC

##
#### Localization
Edit `/etc/locale.gen` to change the system language of your new system  
You need to search your locale, uncomment **en_US.UTF-8 UTF-8** for example  
Then save and run this command:

	$ locale-gen

Create the locale.conf and put the default locale

	$ echo LANG=en_US.UTF-8 > /etc/locale.conf

Make the keyboard layout persistent in vconsole.conf

	$ echo KEYMAP=it > /etc/vconsole.conf

##
#### Network configuration
Create the hostname file. The hostname is the name associated to a network or to a machine  

	$ echo SwagArch > /etc/hostname

You might need some net-tools  
``DOCUMENTATION``: https://wiki.archlinux.org/title/Network_configuration#Network_management

So install net-tools and dhcpcd ans netctl:  

	$ pacman -S net-tools dhcpcd netctl

Then enable the service with this command

	$ systemctl enable dhcpcd

##
#### Root password
Set the root password:

	$ passwd

##
#### Add sudo user
To add a user with root privilegies use the following command: 

	$ useradd -m -G wheel -s /bin/bash zfederick

To add the password to the user

	$ passwd zfederick

Then run this command

	$ visudo

Now you have to uncomment *%whell ALL=(ALL) ALL*


##
#### Boot loader
Choose and install a bootloader  
We will use **GRUB**  
``DOCUMENTATION``: https://wiki.archlinux.org/title/GRUB#Installation

First install the packages grub and efibootmgr  
GRUB is the bootloader while efibootmgr is used by the GRUB installation script to write boot entries to NVRAM  

	$ pacman -S grub efibootmgr

Then mount the EFI partition

	$ mount /dev/sda1 /mnt/boot

If the partition is already mounted skip this command  
To install grub run this  

	$ mkdir /boot/grub 
	$ grub-mkconfig -o /boot/grub/grub.cfg
	$ grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB

##
#### Reboot
Now the system would be correctly installed and we can reboot the system

	$ exit
	$ reboot

After reboot you can login with your username and password
The base system has been installed

##










































