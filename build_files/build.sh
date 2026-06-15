#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# Graphical Environment
dnf5 -y copr enable avengemedia/dms
dnf5 -y install niri dms
dnf5 -y copr disable avengemedia/dms

mkdir -p /etc/systemd/user/niri.service.wants/
ln -s /usr/lib/systemd/user/dms.service \
      /etc/systemd/user/niri.service.wants/dms.service

# DMS Greeter (greetd greeter nativo di DMS)
useradd -r -M -d /var/empty -s /sbin/nologin greeter
dnf5 -y copr enable avengemedia/danklinux
dnf5 -y install greetd dms-greeter
dnf5 -y copr disable avengemedia/danklinux
systemctl enable greetd

# File Manager
dnf5 install -y thunar thunar-volman gvfs gvfs-mtp adw-gtk3-theme

# Docker
rpm --import https://download.docker.com/linux/fedora/gpg
dnf5 config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
dnf5 install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
