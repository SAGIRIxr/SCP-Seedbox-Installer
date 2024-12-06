cd /root && \
bash <(wget -qO- https://raw.githubusercontent.com/SAGIRIxr/Dedicated-Seedbox/main/Install.sh) -u sagiri -p sagirisagiri -c 1024 -q 4.3.8 -l v1.2.14 -x && \
apt install -y curl htop vnstat && \
systemctl stop qbittorrent-nox@sagiri && \
systemctl disable qbittorrent-nox@sagiri && \
tune2fs -m 1 $(df -h / | awk 'NR==2 {print $1}') && \
sed -i 's/WebUI\\Port=[0-9]*/WebUI\\Port=18080/' /home/sagiri/.config/qBittorrent/qBittorrent.conf && \
sed -i 's/Connection\\PortRangeMin=[0-9]*/Connection\\PortRangeMin=55000/' /home/sagiri/.config/qBittorrent/qBittorrent.conf && \
sed -i '/\[Preferences\]/a General\\Locale=zh' /home/sagiri/.config/qBittorrent/qBittorrent.conf && \
sed -i '/\[Preferences\]/a Downloads\\PreAllocation=false' /home/sagiri/.config/qBittorrent/qBittorrent.conf && \
sed -i '/\[Preferences\]/a WebUI\\CSRFProtection=false' /home/sagiri/.config/qBittorrent/qBittorrent.conf && \
echo -e '\nsystemctl enable qbittorrent-nox@sagiri && reboot' >> /root/BBRx.sh && \
shutdown -r +1
