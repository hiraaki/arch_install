read -n1 -r -p "Procure e descomente a linguagem a ser ultilizada no sistema e salve com ctrl+x" key
nano /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
NEW_TIMEZONE=$(tzselect)
test -n "$NEW_TIMEZONE" && cp -fp /usr/share/zoneinfo/"$NEW_TIMEZONE" /etc/localtime
hwclock --systohc --utc
pacman -S iw wpa_supplicant dialog
pacman -S grub os-prober
grub-install --recheck --target=i386-pc /dev/$Disco
grub-mkconfig -o /boot/grub/grub.cfg
echo "digite o nome do computador:"
read swapnil
echo $swapnil > /etc/hostname
echo "digite a senha de rooot:"
passwd
exit
umount -R /mnt
