lang en_US.UTF-8
keyboard us
timezone America/New_York
sshpw --username=root --plaintext centos
rootpw --plaintext centos
auth --useshadow --passalgo=sha512
zerombr
clearpart --all --initlabel
bootloader --timeout=1
network --bootproto=dhcp --device=link --activate
part / --fstype="xfs" --size=6000
# ostree only does separate /boot partition currently
part /boot --size=200 --fstype="xfs"
shutdown
services --disabled=docker-storage-setup,network
services --enabled=NetworkManager,sshd,rc-local
 
ostreesetup --osname="centos-atomic-host" --remote="centos-atomic-continuous" --ref="centos-atomic-host/7/x86_64/devel/continuous" --url="https://ci.centos.org/artifacts/sig-atomic/centos-continuous/ostree/repo/" --nogpg
 
%post
# We copy content of separate /boot partition to root part when building live squashfs image,
# and we don't want systemd to try to mount it when pxe booting
cat /dev/null > /etc/fstab
%end
