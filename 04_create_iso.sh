#!/bin/bash
set -eu -o pipefail

cd "${IMAGE_PATH}"
### Generate md5sum.txt. Generate it two times, to get the own checksum right.
(find . -type f \( ! -iname "*.txt" ! -iname "*.diskdef*" ! -name ubuntu \) -print0 | xargs -0 md5sum >"md5sum.txt")

echo >&2 "===]> Info: Create Isolinux... "
xorriso -as mkisofs \
  -iso-level 3 \
  -full-iso9660-filenames \
  -volid "UNITY_RMX" \
  -b isolinux/isolinux.bin \
  -no-emul-boot \
  -boot-load-size 4 \
  -boot-info-table \
  -c isolinux/boot.cat \
  -eltorito-alt-boot \
  -e boot/grub/efi.img \
  -no-emul-boot \
  -isohybrid-mbr "${ROOT_PATH}/files/isohdpfx.bin" \
  -isohybrid-gpt-basdat \
  -output "${ROOT_PATH}/unity-remix-20.04-desktop-amd64.iso" \
  -graft-points \
   "."
   
