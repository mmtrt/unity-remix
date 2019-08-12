#!/bin/bash

# Place commands that should run in the chrooted system here

# echo "# Remastered" >> /etc/os-release # Don't do this, it disturbs add-apt-repository

echo "In chroot: removing libreoffice-help-xx..."
sudo apt-get autoremove --purge -f -q -y libreoffice-help-de libreoffice-help-en-gb libreoffice-help-es libreoffice-help-fr libreoffice-help-it libreoffice-help-pt-br libreoffice-help-pt libreoffice-help-ru libreoffice-help-zh-cn libreoffice-help-zh-tw libreoffice-l10n-de libreoffice-l10n-en-gb libreoffice-l10n-en-za libreoffice-l10n-es libreoffice-l10n-fr libreoffice-l10n-it libreoffice-l10n-pt-br libreoffice-l10n-pt libreoffice-l10n-ru libreoffice-l10n-zh-cn libreoffice-l10n-zh-tw

echo "In chroot: removing firefox-locale-xx..."
sudo apt-get autoremove --purge -f -q -y firefox-locale-de firefox-locale-es firefox-locale-fr firefox-locale-it firefox-locale-pt firefox-locale-ru firefox-locale-zh-hans thunderbird-locale-de thunderbird-locale-en-gb thunderbird-locale-es-ar thunderbird-locale-es-es thunderbird-locale-es thunderbird-locale-fr thunderbird-locale-it thunderbird-locale-pt-br thunderbird-locale-pt-pt thunderbird-locale-pt thunderbird-locale-ru thunderbird-locale-zh-cn thunderbird-locale-zh-hans thunderbird-locale-zh-hant thunderbird-locale-zh-tw

echo "In chroot: removing mythes-xx..."
sudo apt-get autoremove --purge -f -q -y mythes-de-ch mythes-de mythes-en-au mythes-es mythes-fr mythes-it mythes-pt-pt mythes-ru

echo "In chroot: removing hunspell-xx..."
sudo apt-get autoremove --purge -f -q -y hunspell-de-at-frami hunspell-de-ch-frami hunspell-de-de-frami hunspell-en-au hunspell-en-ca hunspell-en-gb hunspell-en-za hunspell-es hunspell-fr-classical hunspell-fr hunspell-it hunspell-pt-br hunspell-pt-pt hunspell-ru

echo "In chroot: removing language-pack-xx..."
sudo apt-get autoremove --purge -f -q -y language-pack-de-base language-pack-de language-pack-es-base language-pack-es language-pack-fr-base language-pack-fr language-pack-gnome-de-base language-pack-gnome-de language-pack-gnome-es-base language-pack-gnome-es language-pack-gnome-fr-base language-pack-gnome-fr language-pack-gnome-it-base language-pack-gnome-it language-pack-gnome-pt-base language-pack-gnome-pt language-pack-gnome-ru-base language-pack-gnome-ru language-pack-gnome-zh-hans-base language-pack-gnome-zh-hans language-pack-it-base language-pack-it language-pack-pt-base language-pack-pt language-pack-ru-base language-pack-ru language-pack-zh-hans-base language-pack-zh-hans

echo "In chroot: removing hyphen-xx..."
sudo apt-get autoremove --purge -f -q -y hyphen-de hyphen-en-ca hyphen-en-gb hyphen-es hyphen-fr hyphen-it hyphen-pt-br hyphen-pt-pt hyphen-ru

echo "In chroot: removing web launchers..."
sudo apt-get autoremove --purge -f -q -y ubuntu-web-*

echo "In chroot: removing extra locale fonts..."
sudo apt-get autoremove --purge -f -q -y fonts-beng fonts-beng-extra fonts-deva fonts-deva-extra fonts-gargi fonts-gubbi fonts-gujr fonts-gujr-extra fonts-guru fonts-guru-extra fonts-indic fonts-kalapi fonts-khmeros-core fonts-knda fonts-lao fonts-lklug-sinhala fonts-lohit-beng-assamese fonts-lohit-beng-bengali fonts-lohit-deva fonts-lohit-gujr fonts-lohit-guru fonts-lohit-knda fonts-lohit-mlym fonts-lohit-orya fonts-lohit-taml fonts-lohit-taml-classical fonts-lohit-telu fonts-mlym fonts-nakula fonts-nanum fonts-navilu fonts-noto-cjk fonts-orya fonts-orya-extra fonts-pagul fonts-sahadeva fonts-samyak-deva fonts-samyak-gujr fonts-samyak-mlym fonts-samyak-taml fonts-sarai fonts-sil-abyssinica fonts-sil-padauk fonts-smc fonts-smc-anjalioldlipi fonts-smc-chilanka fonts-smc-dyuthi fonts-smc-karumbi fonts-smc-keraleeyam fonts-smc-manjari fonts-smc-meera fonts-smc-rachana fonts-smc-raghumalayalamsans fonts-smc-suruma fonts-smc-uroob fonts-takao-pgothic fonts-taml fonts-telu fonts-telu-extra fonts-thai-tlwg fonts-tibetan-machine fonts-tlwg-garuda fonts-tlwg-garuda-* fonts-tlwg-kinnari fonts-tlwg-kinnari-* fonts-tlwg-laksaman fonts-tlwg-laksaman-* fonts-tlwg-loma fonts-tlwg-loma-* fonts-tlwg-mono fonts-tlwg-mono-* fonts-tlwg-norasi fonts-tlwg-norasi-* fonts-tlwg-purisa fonts-tlwg-purisa-* fonts-tlwg-sawasdee fonts-tlwg-sawasdee-* fonts-tlwg-typewriter fonts-tlwg-typewriter-* fonts-tlwg-typist fonts-tlwg-typist-* fonts-tlwg-typo fonts-tlwg-typo-* fonts-tlwg-umpush fonts-tlwg-umpush-* fonts-tlwg-waree fonts-tlwg-waree-*
