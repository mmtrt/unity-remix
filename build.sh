#!/bin/bash
set -eu -o pipefail

ROOT_PATH=$(pwd)
WORKING_PATH=/root/work
CHROOT_PATH="${WORKING_PATH}/chroot"
IMAGE_PATH="${WORKING_PATH}/image"

if [ -d "$WORKING_PATH" ]; then
  rm -rf "$WORKING_PATH"
fi
mkdir -p "$WORKING_PATH"
if [ -d "${ROOT_PATH}/output" ]; then
  rm -rf "${ROOT_PATH}/output"
fi
mkdir -p "${ROOT_PATH}/output"

echo >&2 "===]> Info: Build dependencies... "
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y -qq -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
  binutils \
  debootstrap \
  squashfs-tools \
  xorriso \
  grub-pc-bin \
  grub-efi-amd64-bin \
  mtools \
  dosfstools \
  zip \
  isolinux \
  syslinux \
  zsync

echo >&2 "===]> Info: Build Ubuntu... "
 /bin/bash -c "
   ROOT_PATH=${ROOT_PATH} \\
   WORKING_PATH=${WORKING_PATH} \\
   CHROOT_PATH=${CHROOT_PATH} \\
   IMAGE_PATH=${IMAGE_PATH} \\
   ${ROOT_PATH}/01_build_file_system.sh
"

echo >&2 "===]> Info: Build Image... "
 /bin/bash -c "
   ROOT_PATH=${ROOT_PATH} \\
   WORKING_PATH=${WORKING_PATH} \\
   CHROOT_PATH=${CHROOT_PATH} \\
   IMAGE_PATH=${IMAGE_PATH} \\
   ${ROOT_PATH}/02_build_image.sh
"

echo >&2 "===]> Info: Prepare Boot for ISO... "
 /bin/bash -c "
   IMAGE_PATH=${IMAGE_PATH} \\
   CHROOT_PATH=${CHROOT_PATH} \\
   ${ROOT_PATH}/03_prepare_iso.sh
"

echo >&2 "===]> Info: Create ISO... "
 /bin/bash -c "
   ROOT_PATH=${ROOT_PATH} \\
   IMAGE_PATH=${IMAGE_PATH} \\
   CHROOT_PATH=${CHROOT_PATH} \\
   ${ROOT_PATH}/04_create_iso.sh
"
livecd_exitcode=$?
if [ "${livecd_exitcode}" -ne 0 ]; then
   echo "Error building"
   exit "${livecd_exitcode}"
fi

### Zip iso and split it into multiple parts - github max size of release attachment is 2GB, where ISO is sometimes bigger than that
cd "${ROOT_PATH}"

# Write update information for use by AppImageUpdate; https://github.com/AppImage/AppImageSpec/blob/master/draft.md#update-information
echo "gh-releases-zsync|mmtrt|unity-remix|continuous|unity-*20.04*.iso.zsync" | dd of="unity-remix-20.04-desktop-amd64.iso" bs=1 seek=33651 count=512 conv=notrunc

# Write zsync file
zsyncmake *.iso

#   zip -s 1500m "${ROOT_PATH}/output/livecd.zip" "${ROOT_PATH}/unity-remix-20.04-desktop-amd64.iso"

### Calculate sha256 sums of built ISO
sha256sum "${ROOT_PATH}"/*.iso >"${ROOT_PATH}/output/sha256"
