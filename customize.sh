#!/bin/bash

# Place commands that should run in the chrooted system here

# echo "# Remastered" >> /etc/os-release # Don't do this, it disturbs add-apt-repository

echo "In chroot: removing libreoffice..."
sudo apt-get autoremove --purge -f -q -y libreoffice*

echo "In chroot: removing firefox thunderbird..."
sudo apt-get autoremove --purge -f -q -y firefox* thunderbird*

echo "In chroot: removing mythes..."
sudo apt-get autoremove --purge -f -q -y mythes*

echo "In chroot: removing hunspell..."
sudo apt-get autoremove --purge -f -q -y hunspell*

echo "In chroot: removing preinstalled apps..."
sudo apt-get autoremove --purge -f -q -y rhythmbox* remmina* totem* transmission* aisleriot* gnome-mahjongg* gnome-mines* gnome-sudoku* simple-scan* gnome-todo* baobab* deja-dup* gnome-calendar* gnome-terminal* example-content* usb-creator-gtk* cheese cheese-common

echo "In chroot: removing language-pack-xx..."
sudo apt-get autoremove --purge -f -q -y language-pack-de-base language-pack-de language-pack-es-base language-pack-es language-pack-fr-base language-pack-fr language-pack-gnome-de-base language-pack-gnome-de language-pack-gnome-es-base language-pack-gnome-es language-pack-gnome-fr-base language-pack-gnome-fr language-pack-gnome-it-base language-pack-gnome-it language-pack-gnome-pt-base language-pack-gnome-pt language-pack-gnome-ru-base language-pack-gnome-ru language-pack-gnome-zh-hans-base language-pack-gnome-zh-hans language-pack-it-base language-pack-it language-pack-pt-base language-pack-pt language-pack-ru-base language-pack-ru language-pack-zh-hans-base language-pack-zh-hans

echo "In chroot: removing hyphen..."
sudo apt-get autoremove --purge -f -q -y hyphen*

echo "In chroot: removing web launchers..."
sudo apt-get autoremove --purge -f -q -y ubuntu-web-*

echo "In chroot: removing extra locale fonts..."
sudo apt-get autoremove --purge -f -q -y fonts-beng fonts-beng-extra fonts-deva fonts-deva-extra fonts-gargi fonts-gubbi fonts-gujr fonts-gujr-extra fonts-guru fonts-guru-extra fonts-indic fonts-kalapi fonts-khmeros-core fonts-knda fonts-lao fonts-lklug-sinhala fonts-lohit-beng-assamese fonts-lohit-beng-bengali fonts-lohit-deva fonts-lohit-gujr fonts-lohit-guru fonts-lohit-knda fonts-lohit-mlym fonts-lohit-orya fonts-lohit-taml fonts-lohit-taml-classical fonts-lohit-telu fonts-mlym fonts-nakula fonts-nanum fonts-navilu fonts-noto-cjk fonts-orya fonts-orya-extra fonts-pagul fonts-sahadeva fonts-samyak-deva fonts-samyak-gujr fonts-samyak-mlym fonts-samyak-taml fonts-sarai fonts-sil-abyssinica fonts-sil-padauk fonts-smc fonts-smc-anjalioldlipi fonts-smc-chilanka fonts-smc-dyuthi fonts-smc-karumbi fonts-smc-keraleeyam fonts-smc-manjari fonts-smc-meera fonts-smc-rachana fonts-smc-raghumalayalamsans fonts-smc-suruma fonts-smc-uroob fonts-takao-pgothic fonts-taml fonts-telu fonts-telu-extra fonts-thai-tlwg fonts-tibetan-machine fonts-tlwg-garuda fonts-tlwg-garuda-* fonts-tlwg-kinnari fonts-tlwg-kinnari-* fonts-tlwg-laksaman fonts-tlwg-laksaman-* fonts-tlwg-loma fonts-tlwg-loma-* fonts-tlwg-mono fonts-tlwg-mono-* fonts-tlwg-norasi fonts-tlwg-norasi-* fonts-tlwg-purisa fonts-tlwg-purisa-* fonts-tlwg-sawasdee fonts-tlwg-sawasdee-* fonts-tlwg-typewriter fonts-tlwg-typewriter-* fonts-tlwg-typist fonts-tlwg-typist-* fonts-tlwg-typo fonts-tlwg-typo-* fonts-tlwg-umpush fonts-tlwg-umpush-* fonts-tlwg-waree fonts-tlwg-waree-*

echo "In chroot: disabling apt ipv6..."
sudo bash -c "echo net.ipv6.conf.all.disable_ipv6=1 >> /etc/sysctl.conf"
sudo bash -c "echo net.ipv6.conf.default.disable_ipv6=1 >> /etc/sysctl.conf"

echo "In chroot: adding libreoffice ppa..."
sudo -E add-apt-repository -y ppa:libreoffice/ppa

echo "In chroot: adding smplayer ppa..."
sudo -E add-apt-repository -y ppa:rvm/smplayer

echo "In chroot: adding ffmpeg-4 ppa..."
sudo -E add-apt-repository -y ppa:jonathonf/ffmpeg-4

echo "In chroot: adding mpv ppa..."
sudo -E add-apt-repository -y ppa:mc3man/mpv-tests

echo "In chroot: adding cybermax's ppas..."
sudo -E add-apt-repository -y ppa:cybermax-dexter/vulkan-backports
sudo -E add-apt-repository -y ppa:cybermax-dexter/sdl2-backport

echo "In chroot: adding nvidia drivers ppa..."
sudo -E add-apt-repository -y ppa:graphics-drivers/ppa

echo "In chroot: installing winehq ppa + winehq..."
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo -E add-apt-repository -y 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
sudo rm winehq.key

echo "In chroot: apt upgrade..."
sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade