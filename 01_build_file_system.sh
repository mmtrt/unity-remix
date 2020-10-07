#!/bin/bash
set -eu -o pipefail

echo >&2 "===]> Info: Checkout bootstrap... "
debootstrap \
  --arch=amd64 \
  --variant=minbase \
  focal \
  "${CHROOT_PATH}" \
  http://archive.ubuntu.com/ubuntu/

echo >&2 "===]> Info: Creating chroot environment... "
mount --bind /dev "${CHROOT_PATH}/dev"
mount --bind /run "${CHROOT_PATH}/run"

cp -r "${ROOT_PATH}/files" "${CHROOT_PATH}/tmp/setup_files"
chroot "${CHROOT_PATH}" /bin/bash -c "/tmp/setup_files/chroot_build.sh"

echo >&2 "===]> Info: Cleanup the chroot environment... "
# In docker there is no run?
#umount "${CHROOT_PATH}/run"
umount "${CHROOT_PATH}/dev"

### Copy grub config without finding macos partition
echo >&2 "===]> Info: Patch Grub... "
cp -rfv "${ROOT_PATH}"/files/grub/30_os-prober "${CHROOT_PATH}"/etc/grub.d/30_os-prober
chmod 755 "${CHROOT_PATH}"/etc/grub.d/30_os-prober
