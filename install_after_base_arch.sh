#!/bin/bash
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
echo "Digite a disco ser instalado o grub"
read Disco
grub-install --recheck --target=i386-pc /dev/$Disco
grub-mkconfig -o /boot/grub/grub.cfg
echo "digite o nome do computador:"
read swapnil
echo $swapnil > /etc/hostname
echo "digite a senha de root:"
passwd
echo "Digite seu usuario:"
read user
useradd -m -G wheel,users -s /bin/bash $user
echo "digite a senha do Usuario:"
passwd $user
echo "Instalando sudo"
pacman -S sudo
read -n1 -r -p "Edite o arquivo decomentando a linha %wheel ALL=(ALL) ALL ctrl+x" key
EDITOR=nano visudo
pacman -S bash-completion
read -n1 -r -p "Edite o arquivo decomentando as linhas '[multilib]' e 'Include = /etc/pacman.d/mirrorlist'" key
nano /etc/pacman.conf
pacman -Syu
pacman -S xorg-server xorg-server-utils
echo "Selecione o driver grafico:"
echo "(1)Intel GPU (2)Nvidia (3)ATI/AMD"
read opcao;                                                                       
if [ $opcao == "1" ];
then
	pacman -S xf86-video-intel
elif [ $opcao == "2" ];
then
	pacman -S nvidia nvidia-libgl
elif [ $opcao == "3" ];
then
	pacman -S xf86-video-ati lib32-mesa-libgl
fi
echo "touch-pad? (s/n)"
read opcao;
if [ $opcao == "s" ];
then
	pacman -S xf86-input-synaptics
fi

