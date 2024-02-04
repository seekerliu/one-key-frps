#!/bin/bash

# 定义frp的版本和安装目录
FRP_VERSION="0.54.0"
INSTALL_DIR="/root/frp_${FRP_VERSION}_linux_amd64"
SERVICE_FILE="/etc/systemd/system/frps.service"

# 下载frp
wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz

# 解压frp
tar -zxvf frp_${FRP_VERSION}_linux_amd64.tar.gz

# 进入解压目录
cd ${INSTALL_DIR}

# 生成一个16位随机字符串作为token
TOKEN=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)

# 创建frps.ini配置文件
cat <<EOF >frps.ini
[common]
bind_port = 17000
authentication_method = token
token = $TOKEN
EOF

# 创建systemd服务文件
cat <<EOF >${SERVICE_FILE}
[Unit]
Description=FRP Server
After=network.target

[Service]
Type=simple
User=root
ExecStart=${INSTALL_DIR}/frps -c ${INSTALL_DIR}/frps.ini

[Install]
WantedBy=multi-user.target
EOF

# 重新加载systemd，使新的服务文件生效
systemctl daemon-reload

# 启用frps服务
systemctl enable frps

# 启动frps服务
systemctl start frps

# 显示frps服务状态
systemctl status frps
