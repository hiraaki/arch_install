#!/bin/bash
pacman -S git
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg –sri
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ..
yaourt -Syu --aur
#echo "Selecione sua Interface Gafica:"
#echo "1)Gnome 2)Cinnamon 3)Mate 4)lxde 5)nada"
echo "Cinnamom?(s/n)"
read opcao;                                                                       
if [ $opcao == "s" ];
then
	sudo pacman -S cinnamon
fi
echo "Tanks and bye bye"


