
这个脚本用于自动化安装和配置基于 Debian 系统的专用种子盒 `qbittorrent-nox`，尤其是在使用 Netcup **服务器控制面板 (SCP)** 安装镜像时。

###功能特点

- 安装基本工具：`curl`，`htop` 和 `vnstat`
- 配置 `qBittorrent` 自定义设置：
  - 默认 **用户名**：`sagiri`
  - 默认 **密码**：`sagirisagiri`
  - 默认 **Web UI 端口**：`18080`
  - 默认 **连接端口**：`55000`
  - **磁盘缓存**：`1024`
- 设置系统开机自动启动 `qbittorrent-nox`
- 调整文件系统设置以优化性能
- 包含安装后自动重启系统的选项

###安装步骤

###前提条件

- 一个通过 Netcup **服务器控制面板 (SCP)** 安装的干净 Debian 系统（Debian 11/12 或 Ubuntu）
- `root` 权限

###步骤

1. 运行以下命令直接从 Netcup SCP 控制面板下载并执行安装脚本：
   ```bash
   bash <(wget -qO- https://raw.githubusercontent.com/SAGIRIxr/SCP-Seedbox-Installer/main/SCP-Seedbox-Installer.sh)
   ```

2. **另一种使用方式**：  
   你也可以直接将 `.sh` 文件的内容复制到 SCP 控制面板中的 **自定义脚本** 部分运行。
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
    echo -e '\nsystemctl enable qbittorrent-nox@sagiri && reboot' >> /root/BBRx.sh && \
    shutdown -r +1
    ```
#可修改的变量

在运行脚本之前，你可能需要修改脚本中的以下变量：

- `{username}`：设置 `qBittorrent` 的默认用户名。例如：`sagiri`
- `{password}`：设置 `qBittorrent` 的默认密码。例如：`sagirisagiri`
- `{webui_port}`：设置 Web UI 端口。例如：`18080`
- `{connection_port}`：设置连接端口。例如：`55000`
- `{cache}`：设置磁盘缓存值。例如：`1024`
