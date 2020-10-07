#!/bin/bash

set -eu -o pipefail

echo >&2 "===]> Info: Configure environment... "

mount none -t proc /proc
mount none -t sysfs /sys
mount none -t devpts /dev/pts

export HOME=/root
export LC_ALL=C

echo "ubuntu-fs-live" >/etc/hostname

echo >&2 "===]> Info: Configure and update apt... "

cat <<EOF >/etc/apt/sources.list
deb http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse
EOF
apt-get update

echo >&2 "===]> Info: Install systemd... "

apt-get install -y systemd-sysv gnupg curl wget

echo >&2 "===]> Info: Configure machine-id and divert... "

dbus-uuidgen >/etc/machine-id
ln -fs /etc/machine-id /var/lib/dbus/machine-id
dpkg-divert --local --rename --add /sbin/initctl
ln -s /bin/true /sbin/initctl

echo >&2 "===]> Info: Install packages needed for Live System... "

export DEBIAN_FRONTEND=noninteractive
apt-get install -y -qq -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
  ubuntu-standard \
  \
  casper \
  lupin-casper \
  discover \
  laptop-detect \
  os-prober \
  network-manager \
  resolvconf \
  net-tools \
  wireless-tools \
  wpagui \
  locales \
  initramfs-tools \
  binutils \
  linux-generic \
  linux-headers-generic \
  grub-efi-amd64-signed \
  intel-microcode \
  thermald

echo >&2 "===]> Info: Install window manager... "

apt-get install --no-install-suggests --no-install-recommends -y -qq -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
  plymouth-theme-ubuntu-logo \
  ubuntu-unity-desktop \
  ubuntu-gnome-wallpapers \
  snapd

echo >&2 "===]> Info: Install Graphical installer... "

apt-get install -y -qq -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
  ubiquity \
  ubiquity-casper \
  ubiquity-frontend-gtk \
  ubiquity-slideshow-ubuntu \
  ubiquity-ubuntu-artwork

echo >&2 "===]> Info: Install useful applications... "

apt-get install -y -qq -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
  git \
  curl \
  nano \
  make \
  gcc \
  dkms

echo >&2 "===]> Info: Remove unused applications ... "

apt-get purge -y -qq \
  transmission-gtk \
  transmission-common \
  gnome-mahjongg \
  gnome-mines \
  gnome-sudoku \
  aisleriot \
  hitori \
  xiterm+thai \
  make \
  gcc \
  vim \
  binutils
  
echo >&2 "===]> Info: removing libreoffice-help-xx..."
apt-get purge -qq -y libreoffice-help-de libreoffice-help-en-gb libreoffice-help-es libreoffice-help-fr libreoffice-help-it libreoffice-help-pt-br libreoffice-help-pt libreoffice-help-ru libreoffice-help-zh-cn libreoffice-help-zh-tw libreoffice-l10n-de libreoffice-l10n-en-gb libreoffice-l10n-en-za libreoffice-l10n-es libreoffice-l10n-fr libreoffice-l10n-it libreoffice-l10n-pt-br libreoffice-l10n-pt libreoffice-l10n-ru libreoffice-l10n-zh-cn libreoffice-l10n-zh-tw

echo >&2 "===]> Info: removing firefox-locale-xx..."
apt-get purge -qq -y firefox-locale-de firefox-locale-es firefox-locale-fr firefox-locale-it firefox-locale-pt firefox-locale-ru firefox-locale-zh-hans thunderbird-locale-de thunderbird-locale-en-gb thunderbird-locale-es-ar thunderbird-locale-es-es thunderbird-locale-es thunderbird-locale-fr thunderbird-locale-it thunderbird-locale-pt-br thunderbird-locale-pt-pt thunderbird-locale-pt thunderbird-locale-ru thunderbird-locale-zh-cn thunderbird-locale-zh-hans thunderbird-locale-zh-hant thunderbird-locale-zh-tw

echo >&2 "===]> Info: removing mythes-xx..."
apt-get purge -qq -y mythes-de-ch mythes-de mythes-en-au mythes-es mythes-fr mythes-it mythes-pt-pt mythes-ru

echo >&2 "===]> Info: removing hunspell-xx..."
apt-get purge -qq -y hunspell-de-at-frami hunspell-de-ch-frami hunspell-de-de-frami hunspell-en-au hunspell-en-ca hunspell-en-gb hunspell-en-za hunspell-es hunspell-fr-classical hunspell-fr hunspell-it hunspell-pt-br hunspell-pt-pt hunspell-ru

echo >&2 "===]> Info: removing language-pack-xx..."
apt-get purge -qq -y language-pack-de-base language-pack-de language-pack-es-base language-pack-es language-pack-fr-base language-pack-fr language-pack-gnome-de-base language-pack-gnome-de language-pack-gnome-es-base language-pack-gnome-es language-pack-gnome-fr-base language-pack-gnome-fr language-pack-gnome-it-base language-pack-gnome-it language-pack-gnome-pt-base language-pack-gnome-pt language-pack-gnome-ru-base language-pack-gnome-ru language-pack-gnome-zh-hans-base language-pack-gnome-zh-hans language-pack-it-base language-pack-it language-pack-pt-base language-pack-pt language-pack-ru-base language-pack-ru language-pack-zh-hans-base language-pack-zh-hans

echo >&2 "===]> Info: removing hyphen-xx..."
apt-get purge -qq -y hyphen-de hyphen-en-ca hyphen-en-gb hyphen-es hyphen-fr hyphen-it hyphen-pt-br hyphen-pt-pt hyphen-ru

echo >&2 "===]> Info: removing gnome-getting-started-docs-xx"
apt-get purge -qq -y gnome-getting-started-docs-de gnome-getting-started-docs-es gnome-getting-started-docs-fr gnome-getting-started-docs-it gnome-getting-started-docs-pt gnome-getting-started-docs-ru

echo >&2 "===]> Info: removing gnome-user-docs-xx"
apt-get purge -qq -y gnome-user-docs-de gnome-user-docs-es gnome-user-docs-fr gnome-user-docs-it gnome-user-docs-pt gnome-user-docs-ru gnome-user-docs-zh-hans

echo >&2 "===]> Info: removing web launchers..."
apt-get purge -qq -y ubuntu-web-*

echo >&2 "===]> Info: removing extra locale fonts..."
apt-get purge -qq -y fonts-beng fonts-beng-extra fonts-deva fonts-deva-extra fonts-gargi fonts-gubbi fonts-gujr fonts-gujr-extra fonts-guru fonts-guru-extra fonts-indic fonts-kacst* fonts-kalapi fonts-khmeros-core fonts-knda fonts-lao fonts-lklug-sinhala fonts-lohit-beng-assamese fonts-lohit-beng-bengali fonts-lohit-deva fonts-lohit-gujr fonts-lohit-guru fonts-lohit-knda fonts-lohit-mlym fonts-lohit-orya fonts-lohit-taml fonts-lohit-taml-classical fonts-lohit-telu fonts-mlym fonts-nakula fonts-nanum fonts-navilu fonts-noto-cjk fonts-orya fonts-orya-extra fonts-pagul fonts-sahadeva fonts-samyak-deva fonts-samyak-gujr fonts-samyak-mlym fonts-samyak-taml fonts-sarai fonts-sil-abyssinica fonts-sil-padauk fonts-smc fonts-smc-anjalioldlipi fonts-smc-chilanka fonts-smc-dyuthi fonts-smc-karumbi fonts-smc-keraleeyam fonts-smc-manjari fonts-smc-meera fonts-smc-rachana fonts-smc-raghumalayalamsans fonts-smc-suruma fonts-smc-uroob fonts-takao-pgothic fonts-taml fonts-telu fonts-telu-extra fonts-thai-tlwg fonts-tibetan-machine fonts-tlwg-garuda fonts-tlwg-garuda-* fonts-tlwg-kinnari fonts-tlwg-kinnari-* fonts-tlwg-laksaman fonts-tlwg-laksaman-* fonts-tlwg-loma fonts-tlwg-loma-* fonts-tlwg-mono fonts-tlwg-mono-* fonts-tlwg-norasi fonts-tlwg-norasi-* fonts-tlwg-purisa fonts-tlwg-purisa-* fonts-tlwg-sawasdee fonts-tlwg-sawasdee-* fonts-tlwg-typewriter fonts-tlwg-typewriter-* fonts-tlwg-typist fonts-tlwg-typist-* fonts-tlwg-typo fonts-tlwg-typo-* fonts-tlwg-umpush fonts-tlwg-umpush-* fonts-tlwg-waree fonts-tlwg-waree-* fonts-arphic-ukai fonts-arphic-uming

apt-get autoremove -y

echo >&2 "===]> Info: Reconfigure environment ... "

locale-gen --purge en_US.UTF-8 en_US
printf 'LANG="C.UTF-8"\nLANGUAGE="C.UTF-8"\n' >/etc/default/locale

dpkg-reconfigure -f readline resolvconf

cat <<EOF >/etc/NetworkManager/NetworkManager.conf
[main]
rc-manager=resolvconf
plugins=ifupdown,keyfile
dns=dnsmasq
[ifupdown]
managed=false
EOF
dpkg-reconfigure network-manager

echo >&2 "===]> Info: Cleanup the chroot environment... "

truncate -s 0 /etc/machine-id
rm /sbin/initctl
dpkg-divert --rename --remove /sbin/initctl
apt-get clean
rm -rf /tmp/* ~/.bash_history
rm -rf /tmp/setup_files

umount -lf /dev/pts
umount -lf /sys
umount -lf /proc

export HISTSIZE=0
