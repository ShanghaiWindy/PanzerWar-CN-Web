#!/bin/bash
# Ubuntu 24.04 一键安装 Docker + 部署装甲纷争官网
# 用法: curl -fsSL <your-url>/setup.sh | bash

set -e

echo "=== 安装 Docker ==="
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin

echo "=== 将当前用户加入 docker 组 ==="
sudo usermod -aG docker $USER

echo "=== 启动 Docker ==="
sudo systemctl enable --now docker

echo "=== 完成! ==="
docker --version
