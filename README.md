# SCP-Seedbox-Installer

This script is designed to automate the installation and configuration of a dedicated seedbox with `qbittorrent-nox` on a Debian-based system, specifically when using the Netcup SCP control panel to install an image.

## Features

- Installs essential tools: `curl`, `htop`, and `vnstat`
- Configures `qBittorrent` with custom settings (e.g., Web UI port, download pre-allocation, etc.)
- Sets up system to automatically start `qbittorrent-nox` on boot
- Adjusts filesystem settings for optimized performance
- Includes an option for automatic system reboot after installation

## Installation

### Prerequisites

- A fresh Debian-based system (Debian 11/12 or Ubuntu) installed via Netcup SCP control panel
- `root` privileges

### Steps

1. Run the following command to download and execute the installation script directly from the Netcup SCP control console:
   ```bash

   bash <(wget -qO- https://raw.githubusercontent.com/SAGIRIxr/SCP-Seedbox-Installer/main/SCP-Seedbox-Installer.sh)
