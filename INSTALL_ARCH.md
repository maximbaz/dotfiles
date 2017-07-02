# Install Arch Linux

## Preparation

1. [Download](https://archlinux.org/download/) ISO and GPG files
2. Verify the ISO file: `$ pacman-key -v archlinux-<version>-dual.iso.sig`
3. Create a bootable usb with: `# dd if=archlinux*.iso of=/dev/sdX && sync`


## UEFI

1. Disable SecureBoot.
2. Set SATA operation to AHCI mode.

## Boot from USB drive

1. Plug in network cable or connect to wifi with `# wifi-menu`, ensure you have internet access.
2. Enable NTP: `# timedatectl set-ntp true`
3. Make sure `# fdisk -l` and `# lvmdiskscan` recognize your disk.
4. Proceed if LVM will be set up for the entire disk, otherwise partition it first.

## LVM configuration

1. Note the disk name with `# fdisk -l`
2. Run `# cfdisk` for that disk and select label type `gpt`.
3. Create partitions:
    - 100M - EFI system
    - 250M - Linux filesystem
    - 100% - Linux LVM
4. Reboot if necessary.
5. Create file systems on EFI and boot partitions:
    - `# mkfs.vfat -F32 /dev/sdX1`
    - `# mkfs.ext4 /dev/sdX2`
6. Encrypt the LVM partition:
    - `# cryptsetup -v luksFormat /dev/sdX3`
    - `# cryptsetup luksOpen /dev/sdX3 luks`
7. Create a physical volume: `# pvcreate /dev/mapper/luks`
8. Create a volume group: `# vgcreate arch /dev/mapper/luks`
9. Create logical volumes:
    - 12GB for swap: `# lvcreate -L 12GB arch -n swap`
    - 70GB for root: `# lvcreate -L 70G arch -n root`
    - The rest for home: `# lvcreate -l 100%FREE arch -n home`
10. Create file systems on the logical volumes:
    - `# mkfs.ext4 /dev/mapper/arch-root`
    - `# mkfs.ext4 /dev/mapper/arch-home`
    - `# mkswap /dev/mapper/arch-swap`
11. Mount logical volumes:
    - `# mount /dev/mapper/arch-root /mnt`
    - `# mkdir /mnt/boot`
    - `# mount /dev/sdX2 /mnt/boot`
    - `# mkdir /mnt/boot/efi`
    - `# mount /dev/sdX1 /mnt/boot/efi`
    - `# mkdir /mnt/home`
    - `# mount /dev/mapper/arch-home /mnt/home`
    - `# swapon /dev/mapper/arch-swap`
12. Help new system discover LVM configuration made on host:
    - `# mkdir /mnt/hostrun`
    - `# mount --bind /run /mnt/hostrun`

## Install Arch Linux

1. Install packages:
```
# pacstrap /mnt base base-devel
                grub efibootmgr os-prober # GRUB will automatically detect other systems
                intel-ucode               # Include Intel microcode patches during boot
                zsh git openssh           # Just enough to create a user and clone dotfiles
                terminus-font             # To make console font readable on HiDPI screens
```
2. Generate fstab entries: `# genfstab -U /mnt >> /mnt/etc/fstab`
3. Open `# vim /mnt/etc/fstab` and make the following adjustments:
    - Change `relatime` to `noatime` for all non-boot partitions to improve durability of SSD.
    - Change `defaults` to `sw` for the swap partition.
4. Enter the new system: `# arch-chroot /mnt`
5. Make console font readable on HiDPI screens:
    - `# setfont ter-132n`
    - `# echo "FONT=ter-132n" > /etc/vconsole.conf`
6. Bind LVM configuration from host:
    - `# mkdir /run/lvm`
    - `# mount --bind /hostrun/lvm /run/lvm`
7. Setup time zone: `# ln -sf /usr/share/zoneinfo/Region/City /etc/localtime`
8. Configure hardware clock `# hwclock --systohc --utc`
9. Configure system locate:
    - `# echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen`
    - `# locale-gen`
    - `# echo LANG=en_US.UTF-8 >> /etc/locale.conf`
    - `# echo LANGUAGE=en_US >> /etc/locale.conf`
    - `# echo LC_ALL=en_US.UTF-8 >> /etc/locale.conf`
10. Configure hostname:
    - `# echo HOSTNAME > /etc/hostname`
    - `# echo "127.0.1.1 HOSTNAME.localdomain HOSTNAME" >> /etc/hosts`
11. Generate initial ramdisk environment:
    - `# vim /etc/mkinitcpio.conf`
    - Add `consolefont` to HOOKS after `base`
    - Add `encrypt` and `lvm2` to HOOKS before `filesystems`
    - `# mkinitcpio -p linux`
12. Install GRUB: `# grub-install`
13. Configure GRUB:
    - `# vim /etc/default/grub`
    - Set `GRUB_CMDLINE_LINUX="cryptdevice=/dev/sdX3:luks resume=/dev/mapper/arch-swap"`
    - Set`GRUB_GFXMODE=1280x1024x32,1024x768x32,auto`
    - Comment out `#GRUB_GFXPAYLOAD_LINUX` (terminus font is great at native resolution)
14. Configure GRUB: `# grub-mkconfig -o /boot/grub/grub.cfg`
15. Create a user:
    - `# useradd -m -g users -G wheel -s /bin/zsh USERNAME`
    - `# passwd USERNAME`
    - `# EDITOR=vi visudo` and uncomment sudo access for `wheel` group
16. Generate machine id: `# dbus-uuidgen --ensure`
16. Set `zsh` as default shell for root: `chsh -s /bin/zsh`
15. Disable root password: `# passwd -dl root`

## Final system configuration

1. Login as the new user: `# su - USERNAME`
2. Finish system setup:
    - Clone dotfiles: `$ git clone https://github.com/maximbaz/dotfiles.git ~/.dotfiles`
    - Bootstrap native packages: `$ ~/bin/pacman-bootstrap.sh native`
    - Install configuration: `$ ~/.dotfiles/setup.sh`
    - Reinitialize shell: `$ exec zsh -l`
    - Install AUR package manager: 
        - `$ git clone https://aur.archlinux.org/yay.git`
        - `$ cd yay`
        - `$ makepkg -i`
    - Bootstrap foreign packages: `$ ~/bin/pacman-bootstrap.sh foreign`
3. Exit new system and reboot:
    - `$ exit`
    - `# exit`
    - `# umount -R /mnt`
    - `# swapoff -a`
    - `# reboot`
