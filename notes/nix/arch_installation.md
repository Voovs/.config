# Install Archlinux 
An easy to follow guide for setting up a basic archlinux installation. This
was written while installing on macos 10.15.5 with qemu. It should be almost
identical, and likely easier, on a dedicated system. The qemu command I used
for installation is below
Don't follow the guide blindly — modify steps to your liking. This roughly
follows the arch wiki's guide, it's just a little less overwhelming
```sh
qemu-system-x86_64 \
    -m 4G \
    -boot d \
    -display cocoa \
    -machine type=q35,accel=hvf \
    -smp 2 \
    -drive file=archlinux-2021.01.01.qcow2,media=disk,if=virtio \
    -cdrom /Users/vselin/documents/safe_house/safe/arch_vm/archlinux-2021.01.01-x86_64.iso
```
## Init
setfont ter-120n
	Sets the font. You can check available fonts in /usr/share/kbd/consolefonts/
localectl list-keymaps
	List available keyboards. Pipe into grep once you know the name
loadkeys
	Sets up your keyboard. Default uses a US eng layout. Remember this code
	for later!
ls /sys/firmware/
	If a directory called /efi is listed, you're booted in uefi mode. If not,
	you're likely in BIOS mode. The remainder of the guide follows BIOS mode

## Basic network
[ip link | ip a]
	Checks your network devices. Make sure one of them is in the UP state
ping google.com
curl google.com
	`ping` requires an ICMP protocol to be supported on the network, which
	qemu does not enable in its default network configuration. `curl` can
	be used to test a TCP connection, which is absolutely required for setup.
	qemu does provide an emulated ethernet port capable of TCP in default
timedatectl set-ntp true
	Assuming there's internet, this will synchronize the system clock
timedatectl status
	Check the system clock. NTP should be "active"
cat /etc/pacman.d/mirrorlist
	Shows the example mirrorlist. Consider saving this to verify the following 
reflector --country Canada --age 12 --sort rate --save /etc/pacman.d/mirrorlist
	Takes a second to rate the download speeds. Often errors a lot on qemu, 
	though should be fine even with errors. It's possible the rater uses ICMP
vim /etc/pacman.d/mirrorlist
	Consider editing this file to add kernel.org, which is considered fast.
	https://mirrors/kernel.org/archlinux/$repo/os/$arch
pacman -Syy
	Synchronize the servers. Not sure what this does, tho it should work
## Partitioning
[lsblk | fdisk -l]
	Should see a bunch of possible drives. Ignore rom, loop, and airoot.
	None of the un-ignored drives should be mounted
fdisk /dev/vda
	The following will go through an interactive prompt to setup BIOS MBA
	- Command (m for help): n
		Creates a new partition
	- Select (default p): p
		Selects a primary partition
	- Partition number (1-4, default 1): <ENTER>
	- First sector...: <ENTER>
	- Last sector...: +4G
		This defines the size of the partition. Default is the size of the
		entire remaining drive, so likely restrict it. The above creates a 
		4G partition, which'll be used for swap on a 40G drive
	- Command (m for help): t
		Selects the partition we just made
	- Hex code (type L to list all codes): 82
		Consider looking through the codes. 82 denotates a linux swap parition
		which is the first type of parition we want to make
	- Command (m for help): n
	- SElect (default p): p
	- Partition number...: <ENTER>
	- First sector...: <ENTER>
	- Last sector...: <ENTER>
		Creates our root parition, with the size of the remaining disk. Only
		do this after you have created all other required partitions!
	- Command (m for help): w
		Writes the changes, actually creating the specified paritions.
		Before they were only held as instructions in ram. Make sure
		You got your partitions right before this step!
[lsblk | fdisk -l]
	Check that your drive partitions are showing up as expected
mkswap /dev/vda1
	Creates a swap partition. Make sure the path is pointing at your
	intended swap partition. All partitions are in /dev
swapon /dev/vda1
	Enables the swap partition, essentially mounting it
mkfs.ext4 /dev/vda2
	Creates an ext4 file system on the vda2 partition. You'll want
	to do something similar for your root partition. Other file
	systems are available, though ext4 is quite popular on linux
mount /dev/vda2 /mnt
	Mounts the partition. Always mount to /mnt in archlinux. All
	non-swap partitions should be mounted here?
[lsblk | fdisk -l]
	Check your paritions are mounted where expected
## Installation
*EXIT NOTE*
	If you need to exit the installer after this point, you'll
	need to re-mount the partitions on reboot. Everything else
	is likely saved from last time
pacstrap /mnt base linux linux-firmware vim
	Installs essential packages to root. You'll likely want to use 
	the exact command above. Any number of additional arguments can
	be placed at the end, like what `vim` is doing here
	gitlab.archlinux.org/archlinux/archiso/-/blob/master/configs/releng/packages.x86_64

	On a virtual machine: Ignore both of the below!
	On an Intel x86_64 machine: add the argument `intel-ucode` at the end
	On an AMD x86_64 machine: add the argument `amd-ucode` at the end

	Downloading may take a while, especially on vms with network overhead...
	Took my qemu machine almost 12 minutes
## System configuration
genfstab -U /mnt >> /mnt/etc/fstab
	Generates fstab file. -U makes a file system table based on 
	the UUID of our partitions. Likely use this exact command
cat /mnt/etc/fstab
	Check to see if the file system table is as expected. File
	layout looks like this. mount-point and fs-type are important.
	Keep in mind the swap partition's mountpoint is `none`
	```
	partition-name
	UUID	mount-point    fs-type    option    fs-checks
	```
arch-chroot /mnt
	Makes /mnt the root directory. This makes us leave the 
	installer, so your PS1 will change
*EXIT NOTE*
	If you exit the installer after this point, after remounting 
	the partitions, run `arch-chroot /mnt` again
timedatectl list-timezones
	Shows you all the available timezones. Find yours.
	You can grep pipe through this list, looking for 
	the nearest major city. Output is case sensitive!
ln -sf /usr/share/zoneinfo/America/Edmonton /etc/localtime
	Softlinks the local time file. Change `America/Edmonton`
	to the string you found from `...list-timezones` above
hwclock --systohc
	Generates /etc/adjtime based on /etc/localtime. This 
	command assumes the hardware clock is set to UTC
vim /etc/locale-gen
	Uncomment line 177 `en_US.UTF-8 UTF-8`. This indicates
	to programs what type of time/date/language and such
	to use, based on local standards. Try to use UTF-8
locale-gen
	Generates the locale file based on above
vim /etc/locale.conf
	Add a line `LANG=en_US.UTF-8`
vim /etc/vconsole.conf
	This step is only required if you changed the keyboard
	layout at the very beginning
	Add a line `KEYMAP=de_CH-latin1`, where the code is the
	keyboard code you used at the start
vim /etc/hostname
	Put your computer's name on the first line. Consult this
	guide for good names. In general, use something thematic
	https://tools.ietf.org/html/rfc1178
	legal char regex: /[A-z0-9][A-z0-9-]{0,62}/
vim /etc/hosts
	Add the following format to your file. Replace 
	`Annas-Archangel` with your own host name. The spaceing
	looks like <TAB> for lines 1 and 3 and <TAB><TAB> for 2
	```
	127.0.0.1	localhost
	::1			localhost
	127.0.1.1	Annas-Archangel.localdomain Annas-Archangel
	```
passwd
	Changes or adds a root password
# Post-installation progress
pacman -S grub networkmanager network-manager-applet wireless_tools wpa_supplicant dialog os-prober mtools dosfstools base-devel linux-headers bluez bluez-utils cups xdg-utils xdg-user-dirs
	Installs a bunch of stuff we'll use from this point 
	forward. Accept all the defaults for the prompts
grub-install --target=i386-pc /dev/vda
	Change the target and path accordingly
systemctl enable bluetooth
systemctl enable org.cups.cupsd
systemctl enable NetworkManager
	The above should give us bluetooth, printing, and 
	internet, though it didn't work on qemu
useradd -mG wheel vselin
	Change `vselin` to your username. This will set up
	a new user in the wheel group
passwd vselin
	Set a password for this user
EDITOR=vim visudo
	Find the line with the %wheel group, near the bottom.
	Uncomment the top one, which requires user passwords
exit
	Exits from the os
umount -a
	Unmounts all partitions. Note the command is `umount`
reboot

*IMPORTANT AFTER REBOOT*
	DO NOT go into the installation medium again. Instead 
	scroll down to "boot existing os" and select that option.
	If you entered the installation medium, `reboot` again
Annas-Archangel login: vselin
Password: 
	Username and password of the user you made
ip a
	Check that the network is up. Ignore what lo says, the
	en... should be UP
curl google.com
	Checks if TCP is working, which it should with the network UP
*if network is down*
systemctl enable NetworkManager
	Only do this if the `ip a` showed your network was down.
	You'll need to do it if it failed when you tried with root.
	Type in your user password again to enable sudo privileges
reboot
	"boot existing os" and repeat network checking steps above
*done*
sudo pacman -S xf86-video-qxl
	Installs some sort of graphic drivers for qemu?
	For intel graphics: `xf86-video-intel`
	For amd graphics: `xf86-video-amdgpu`
	For intel graphics: `nvidia nvidia-utils`
sudo pacman -S xorg
	Installs X11 drivers. Necessary unless you're not planning 
	to use GUI or want to risk Wayland
sudo pacman -S gnome
	Installs the gnome desktop environment. Consider using a
	display manager and window manager instead. `sddm` is a 
	lightweight alternative
systemctl enable gdm
	This makes gnome boot automatically. Alternatively, you
	could start it manually every time with `...start gdm`
sudo pacman -S git
	Gets us git version control. Probably something you want
## AUR helper
sudo pacman -S --needed base-devel
	Just checks you have the base packages downloaded. You'll
	also need git for this
git clone https://aur.archlinux.org/paur.git
	Clones the paur aur program. Check out alternative aur 
	helpers here:
	https://wiki.archlinux.org/index.php/AUR_helpers
cd paru
	Move into the cloned directory
makepkg -si PKGBUILD
	Will build the aur package. 

	If using paur, paur is build on rust, so you'll likely want
	to grab rustup, when it ask for which compiler to download. 
	It will then fail to build, having no toolchain installed
	```
	rustup install stable
	```
	Once the toolchain is installed, rerun `makepkg...`
paru -S ttf-mac-fonts
	Installs mac fonts. Just a good test for if paru works
reboot
	Rebooting will boot you into your graphical desktop

## SSH setup
*if trapped in gui land*
sudo systemctl disable gdm
	Disables automatic gdm. Check if it's enabled first with
	`status`. Now when you reboot, you'll start in shell.
	NOTE: you can still setup ssh from a GUI terminal
*done*
*on qemu*
-nic user,hostfwd=tcp::10022-:22
	Option forwards guest port 22 to host port 10022
*done*
[pacman -Qs ssh | pacman -Qi openssh]
	Either command should show openssh installed. Otherwise,
	install it with `-S`
systemctl start sshd
	Activates the ssh daemon. Use `enable` to start on boot
systemctl status sshd
	Lists the status, which should be active
*on client*
ssh -p 10022 vselin@localhost
	Replace `vselin` with the user you want to log into. 
	Replace `10022` with the port connected to the server
*done*

## Additional reference
Step by step ssh guide I followed
https://www.reddit.com/r/linuxquestions/comments/51wlcr/how_do_i_sshrdesktop_to_my_qemu_vm_from_my_host/
Lots of pre-baked formual for ssh and nongraphical boots
https://fadeevab.com/how-to-setup-qemu-output-to-console-and-automate-using-shell-script/

Maybe better?
http://nickdesaulniers.github.io/blog/2018/10/24/booting-a-custom-linux-kernel-in-qemu-and-debugging-it-with-gdb/
