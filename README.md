# SCP-Seedbox-Installer

This script is designed to automate the installation and configuration of a dedicated seedbox with `qbittorrent-nox` on a Debian-based system, specifically when using the Netcup **Server Control Panel (SCP)** to install an image.

## Features

- Installs essential tools: `curl`, `htop`, and `vnstat`
- Configures `qBittorrent` with custom settings:
  - Default **username**: `sagiri`
  - Default **password**: `sagirisagiri`
  - Default **Web UI port**: `18080`
  - Default **connection port**: `55000`
- Sets up system to automatically start `qbittorrent-nox` on boot
- Adjusts filesystem settings for optimized performance
- Includes an option for automatic system reboot after installation

## Installation

### Prerequisites

- A fresh Debian-based system (Debian 11/12 or Ubuntu) installed via Netcup **Server Control Panel (SCP)**
- `root` privileges

### Steps

1. Run the following command to download and execute the installation script directly from the Netcup SCP control console:
   ```bash

   bash <(wget -qO- https://raw.githubusercontent.com/SAGIRIxr/SCP-Seedbox-Installer/main/SCP-Seedbox-Installer.sh)
