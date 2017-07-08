#!/bin/bash
lsblk
echo Digite o Disco que ira ser instalado o linux:
read Disco
echo Vc quer limpar o disco e instalar o linux, ou quer manter o disco da maneira que está e criar uma nova partição linux:
echo 	1-limpar o disco  2-Criar nova partição linux
echo OBS: Garanta que haja spaço suficiente no segundo caso!                                                       
read opcao;                                                                         
if [ $opcao == "1" ];
then	
	echo Digite o começo e o fim da sua particião linux:
	echo inicio linux:
	read inicio_linux;	
	echo fim linux:
	read fim_linux;
	echo Digite o começo e o fim da sua particião swap:
	echo inicio swap:
	read inicio_swap;	
	echo fim swap:
	read fim_swap;	
	parted /dev/$Disco mklabel msdos 
	parted /dev/$Disco mkpart primary ext4 $inicio_linux $fim_linux 
	parted /dev/$Disco set 1 boot on 
	parted /dev/$Disco mkpart primary linux-swap $inicio_swap $fim_swap
	parted /dev/$Disco print
	partition=1
	mkfs.ext4 /dev/$Disco$partition
	partition=2
	mkswap /dev/$Disco$partition
	swapon /dev/$Disco$partition
	partition=1
	mount /dev/$Disco$partition /mnt
elif [ $opcao == "2" ];
then
	parted /dev/$Disco print
	echo Digite o começo e o fim da sua particião linux:
	echo inicio linux:
	read inicio_linux
	echo fim linux:
	read fim_linux
	echo Digite o começo e o fim da sua particião swap:
	echo inicio swap:
	read inicio_swap
	echo fim swap:
	read fim_swap
	parted /dev/$Disco mkpart primary ext4 $inicio_linux $fim_linux 
	parted /dev/$Disco print
	echo selecione a partição a bootavel
	read particao
	parted /dev/$Disco set $particao boot on
	parted /dev/$Disco mkpart primary linux-swap $inicio_swap $fim_swap
	parted /dev/$Disco print
	mkfs.ext4 /dev/$Disco$particao
	particao_swap=$(($particao+1))	
	mkswap /dev/$Disco$particao_swap
	swapon /dev/$Disco$particao_swap
	mount /dev/$Disco$particao /mnt
fi
read -n1 -r -p "Descomente o mirror requerido e salve com ctrl+x" key
nano /etc/pacman.d/mirrorlist
pacstrap -i /mnt base base-devel
genfstab -U /mnt > /mnt/etc/fstab
cat /mnt/etc/fstab
arch-chroot /mnt


