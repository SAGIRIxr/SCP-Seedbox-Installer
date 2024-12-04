For the Chinese version, please refer to [简体中文](https://github.com/SAGIRIxr/SCP-Seedbox-Installer/blob/main/README_zh.md).


## SCP-Seedbox-Installer

This script automates the installation and configuration of a dedicated seedbox with `qbittorrent-nox` on a Debian-based system, specifically when using the Netcup **Server Control Panel (SCP)** to install an image.

### Features

- Installs essential tools: `curl`, `htop`, and `vnstat`
- Configures `qBittorrent` with custom settings:
  - Default **username**: `sagiri`
  - Default **password**: `sagirisagiri`
  - Default **Web UI port**: `18080`
  - Default **connection port**: `55000`
  - **Disk cache**: `1024`
- Sets up system to automatically start `qbittorrent-nox` on boot
- Adjusts filesystem settings for optimized performance
- Includes an option for automatic system reboot after installation

### Installation

#### Prerequisites

- A fresh Debian-based system (Debian 11/12 or Ubuntu) installed via Netcup **Server Control Panel (SCP)**
- `root` privileges

#### Steps

1. Run the following command to download and execute the installation script directly from the Netcup SCP control console:
   ```bash
   bash <(wget -qO- https://raw.githubusercontent.com/SAGIRIxr/SCP-Seedbox-Installer/main/SCP-Seedbox-Installer.sh)
   ```

2. **Alternative usage**:  
   You can also copy the contents of the `.sh` file and paste it directly into the **Custom Script** section of the SCP control panel for installation.

    ```bash
    cd /root && \
    bash <(wget -qO- https://raw.githubusercontent.com/SAGIRIxr/Dedicated-Seedbox/main/Install.sh) -u {username} -p {password} -c {cache} -q 4.3.8 -l v1.2.14 -x && \
    apt install -y curl htop vnstat && \
    systemctl stop qbittorrent-nox@{username} && \
    systemctl disable qbittorrent-nox@{username} && \
    tune2fs -m 1 $(df -h / | awk 'NR==2 {print $1}') && \
    sed -i 's/WebUI\\Port=[0-9]*/WebUI\\Port={webui_port}/' /home/{username}/.config/qBittorrent/qBittorrent.conf && \
    sed -i 's/Connection\\PortRangeMin=[0-9]*/Connection\\PortRangeMin={connection_port}/' /home/{username}/.config/qBittorrent/qBittorrent.conf && \
    sed -i '/\[Preferences\]/a General\\Locale=zh' /home/{username}/.config/qBittorrent/qBittorrent.conf && \
    sed -i '/\[Preferences\]/a Downloads\\PreAllocation=false' /home/{username}/.config/qBittorrent/qBittorrent.conf && \
    sed -i '/\[Preferences\]/a WebUI\\CSRFProtection=false' /home/{username}/.config/qBittorrent/qBittorrent.conf && \
    echo -e '\nsystemctl enable qbittorrent-nox@{username} && reboot' >> /root/BBRx.sh && \
    shutdown -r +1
    ```

#### Customizable Variables

Before running the script, you may need to modify the following variables in the script:

- `{username}`: Set the default username for `qBittorrent`. Example: `sagiri`
- `{password}`: Set the default password for `qBittorrent`. Example: `sagirisagiri`
- `{webui_port}`: Set the Web UI port. Example: `18080`
- `{connection_port}`: Set the connection port. Example: `55000`
- `{cache}`: Set the disk cache value. Example: `1024`
