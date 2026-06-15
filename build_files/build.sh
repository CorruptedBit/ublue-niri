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

# VsCode from Microsoft
rpm --import https://packages.microsoft.com/keys/microsoft.asc

cat << 'EOF' > /etc/yum.repos.d/vscode.repo
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
autorefresh=1
type=rpm-md
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

dnf5 install -y code

# Terra Software
dnf5 install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
dnf5 config-manager setopt terra.enabled=1
dnf5 install -y zed
dnf5 config-manager setopt terra.enabled=0


#### Example for enabling a System Unit File

systemctl enable podman.socket
