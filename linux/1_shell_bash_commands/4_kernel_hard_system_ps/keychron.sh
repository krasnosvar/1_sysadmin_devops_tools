#if in via web error appears
# https://www.reddit.com/r/Keychron/comments/12f3gat/useviaapp_in_linux_ie_via_support_useful_for/



echo 'KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0350", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"' | sudo tee -a /etc/udev/rules.d/99-vial.rules > /dev/null

sudo udevadm control --reload-rules && sudo udevadm trigger