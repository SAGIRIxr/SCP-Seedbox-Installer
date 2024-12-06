#!/bin/bash

# 默认参数
username="sagiri"
password="sagirisagiri"
cache=1024
webui_port=18080
connection_port=55000

# 获取命令行参数
while getopts "u:p:c:w:o:h" opt; do
  case "$opt" in
    u) username="$OPTARG" ;;
    p) password="$OPTARG" ;;
    c) cache="$OPTARG" ;;
    w) webui_port="$OPTARG" ;;
    o) connection_port="$OPTARG" ;;
    h)
      echo "用法: bash <(wget -qO- https://raw.githubusercontent.com/SAGIRIxr/Dedicated-Seedbox/main/Install.sh) [参数]"
      echo "  -u  用户名 (默认: sagiri)"
      echo "  -p  密码 (默认: sagirisagiri)"
      echo "  -c  缓存大小 (默认: 1024)"
      echo "  -w  WebUI端口 (默认: 18080)"
      echo "  -o  连接端口 (默认: 55000)"
      echo "  -h  显示帮助"
      exit 0
      ;;
    *) echo "未知参数: $opt"; exit 1 ;;
  esac
done

# 安装和配置
cd /root || exit 1
bash <(wget -qO- https://raw.githubusercontent.com/SAGIRIxr/Dedicated-Seedbox/main/Install.sh) -u "$username" -p "$password" -c "$cache" -q 4.3.8 -l v1.2.14 -x

apt install -y curl htop vnstat

systemctl stop "qbittorrent-nox@$username"
systemctl disable "qbittorrent-nox@$username"

tune2fs -m 1 "$(df -h / | awk 'NR==2 {print $1}')"

# 配置文件路径
config_path="/home/$username/.config/qBittorrent/qBittorrent.conf"

# 检查并等待配置文件生成
while [ ! -f "$config_path" ]; do
  echo "$config_path 不存在，正在等待 20 秒..."
  sleep 20
done

# 修改配置
sed -i "s/WebUI\\Port=[0-9]*/WebUI\\Port=$webui_port/" "$config_path" || echo "WebUI\\Port=$webui_port" >> "$config_path"
sed -i "s/Connection\\PortRangeMin=[0-9]*/Connection\\PortRangeMin=$connection_port/" "$config_path" || echo "Connection\\PortRangeMin=$connection_port" >> "$config_path"
grep -q "General\\Locale=zh" "$config_path" || echo "General\\Locale=zh" >> "$config_path"
grep -q "Downloads\\PreAllocation=false" "$config_path" || echo "Downloads\\PreAllocation=false" >> "$config_path"
grep -q "WebUI\\CSRFProtection=false" "$config_path" || echo "WebUI\\CSRFProtection=false" >> "$config_path"

# 写入重启脚本
echo -e "\nsystemctl enable qbittorrent-nox@$username && reboot" >> /root/BBRx.sh

# 确保脚本可执行
chmod +x /root/BBRx.sh

# 定时重启
shutdown -r +1
