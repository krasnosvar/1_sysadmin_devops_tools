qemu-system-aarch64 \
    -machine type=q35,accel=hvf \
    -smp 2 \
    -hda /Users/den/Downloads/focal-server-cloudimg-arm64.dmg \
    -m 4G \
    -vga virtio \
    -usb \
    -device usb-tablet \
    -display default,show-cursor=on


qemu-system-x86_64 \
    -machine type=q35,accel=hvf \
    -smp 2 \
    -hda ubuntu-20.04.1-desktop-amd64.qcow2 \
    -cdrom ./ubuntu-20.04.1-desktop-amd64.iso \
    -m 4G \
    -vga virtio \
    -usb \
    -device usb-tablet \
    -display default,show-cursor=on