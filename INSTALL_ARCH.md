# Install Arch Linux

## Preparation

1. [Download](https://archlinux.org/download/) ISO and GPG files
2. Verify the ISO file: `$ pacman-key -v archlinux-<version>-dual.iso.sig`
3. Create a bootable usb with: `# dd if=archlinux*.iso of=/dev/sdX && sync`

## UEFI

1. Temporarily disable Secure Boot.
2. Set SATA operation to AHCI mode.

## Boot from USB drive

1. Plug in network cable or connect to wifi with `# wifi-menu`, ensure you have internet access.
2. Enable NTP: `# timedatectl set-ntp true`
3. Set larger font if needed:
    - `# pacman -Sy terminus-font`
    - `# setfont ter-132n`

## Partition the disk

1. Note the disk name with:
    ```
    # fdisk -l
    ```
2. Run `# cfdisk` for that disk and select label type `gpt`.
3. Create partitions:
    - 100M - EFI system
    - 100% - Linux filesystem
4. Create file system on the EFI partition:
    ```
    # mkfs.vfat -n EFI -F32 /dev/sdX1
    ```
5. Encrypt the Linux partition:
    ```
    # cryptsetup luksFormat /dev/sdX2
    # cryptsetup luksOpen /dev/sdX2 luks
    ```
6. Create file system on the encrypted Linux partition:
    ```
    # mkfs.btrfs -L btrfs /dev/mapper/luks
    ```
7. Create and mount subvolumes:
    ```
    # mount /dev/mapper/luks /mnt
    # btrfs subvolume create /mnt/root
    # btrfs subvolume create /mnt/home
    # btrfs subvolume create /mnt/pkgs
    # btrfs subvolume create /mnt/logs
    # btrfs subvolume create /mnt/tmp
    # btrfs subvolume create /mnt/snapshots
    # umount /mnt
    # mount -o noatime,nodiratime,discard,compress=lzo,subvol=root /dev/mapper/luks /mnt
    # mkdir -p /mnt/mnt/btrfs-root
    # mkdir -p /mnt/boot/EFI
    # mkdir -p /mnt/home
    # mkdir -p /mnt/var/cache/pacman/pkg
    # mkdir -p /mnt/var/log
    # mkdir -p /mnt/var/tmp
    # mkdir -p /mnt/.snapshots
    # mount /dev/sdX1 /mnt/boot/EFI
    # mount -o noatime,nodiratime,discard,compress=lzo,subvol=/ /dev/mapper/luks /mnt/mnt/btrfs-root
    # mount -o noatime,nodiratime,discard,compress=lzo,subvol=home /dev/mapper/luks /mnt/home
    # mount -o noatime,nodiratime,discard,compress=lzo,subvol=pkgs /dev/mapper/luks /mnt/var/cache/pacman/pkg
    # mount -o noatime,nodiratime,discard,compress=lzo,subvol=logs /dev/mapper/luks /mnt/var/log
    # mount -o noatime,nodiratime,discard,compress=lzo,subvol=tmp /dev/mapper/luks /mnt/var/tmp
    # mount -o noatime,nodiratime,discard,compress=lzo,subvol=snapshots /dev/mapper/luks /mnt/.snapshots
    ```

## Install Arch Linux

1. Install packages:
    ```
    # pacstrap /mnt base base-devel
                    grub efibootmgr           # boot manager
                    intel-ucode               # Include Intel microcode patches during boot
                    zsh git openssh           # Just enough to create a user and clone dotfiles
                    terminus-font             # To make console font readable on HiDPI screens
                    networkmanager            # Because wired connection may not work after installation
    ```
2. Generate fstab entries:
    ```
    # genfstab -U /mnt >> /mnt/etc/fstab
    ```
3. Enter the new system:
    ```
    # arch-chroot /mnt
    ```
4. Persist using larger console font after reboot:
    ```
    # echo "FONT=ter-132n" > /etc/vconsole.conf
    ```
5. Setup time zone:
    ```
    # ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
    ```
6. Configure hardware clock:
    ```
    # hwclock --systohc --utc
    ```
7. Configure system locate:
    ```
    # echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    # locale-gen
    # echo LANG=en_US.UTF-8 >> /etc/locale.conf
    # echo LANGUAGE=en_US >> /etc/locale.conf
    # echo LC_ALL=en_US.UTF-8 >> /etc/locale.conf
    ```
8. Configure hostname:
    ```
    # echo HOSTNAME > /etc/hostname
    # vi /etc/hostname

    127.0.0.1	localhost.localdomain	localhost
    ::1	 	localhost.localdomain	localhost
    127.0.0.1	HOSTNAME.localdomain	HOSTNAME
    ```
9. Configure passwordless unlock of root partition:
    ```
    # dd bs=512 count=4 if=/dev/urandom of=/crypto_keyfile.bin
    # chmod 000 /crypto_keyfile.bin
    # chmod 600 /boot/initramfs-linux*
    # cryptsetup luksAddKey /dev/sdX2 /crypto_keyfile.bin
    ```
10. Generate initial ramdisk environment:
    ```
    # vi /etc/mkinitcpio.conf
    - Add `consolefont` to HOOKS after `base`
    - Add `encrypt` to HOOKS before `filesystems`
    - Remove `fsck` from HOOKS
    - Add `/crypto_keyfile.bin` to FILES

    # mkinitcpio -p linux
    ```
11. Configure bootloader:
    ```
    # vi /etc/default/grub
    - Set:         GRUB_CMDLINE_LINUX="cryptdevice=/dev/sdX2:luks:allow-discards"
    - Set:         GRUB_GFXMODE=1280x1024x32,1024x768x32,auto
    - Uncomment:   GRUB_ENABLE_CRYPTODISK=y
    - Comment out: GRUB_GFXPAYLOAD_LINUX (terminus font is great at native resolution)

    # grub-mkconfig -o /boot/grub/grub.cfg
    # grub-install
    ```
12. Generate machine id:
    ```
    # dbus-uuidgen --ensure
    ```
13. Set `zsh` as default shell for root:
    ```
    # chsh -s /bin/zsh
    ```
14. Create a user:
    ```
    # useradd -m -g users -G wheel -s /bin/zsh USERNAME
    # passwd USERNAME
    # EDITOR=vi visudo
    - Uncomment sudo access for `wheel` group
    ```
15. Exit new system and reboot:
    ```
    # exit
    # umount -R /mnt
    # reboot
    ```

## Final system configuration

1. Login as the new user
2. Start NetworkManager service:
    ```
    $ sudo systemctl start NetworkManager
    ```
3. Clone dotfiles:
    ```
    $ git clone https://github.com/maximbaz/dotfiles.git ~/.dotfiles
    ```
4. Bootstrap pacman packages:
    ```
    $ ~/.dotfiles/bin/bootstrap.sh pacman
    ```
5. Install AUR package manager:
    ```
    $ git clone https://aur.archlinux.org/yay.git /tmp/yay
    $ cd /tmp/yay
    $ makepkg -i
    ```
6. Bootstrap AUR packages:
    ```
    $ ~/.dotfies/bin/bootstrap.sh aur
    ```
7. Setup dotfiles:
    ```
    $ ~/.dotfiles/setup.sh
    ```
8. Reboot:
    ```
    # reboot
    ```
9. Disable root password:
    ```
    # passwd -dl root
    ```
