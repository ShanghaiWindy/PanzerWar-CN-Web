#!/bin/bash
# Ubuntu 24.04 一键安装 Docker + 配置国内镜像加速
# 用法: bash setup.sh

set -e

echo "=== 安装 Docker ==="
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "=== 配置国内镜像加速 ==="
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<'EOF'
{
  "registry-mirrors": [
    "https://hub.rat.dev",
    "https://docker.1ms.run",
    "https://docker.wanpeng.top",
    "https://doublezonline.cloud"
  ]
}
EOF

echo "=== 将当前用户加入 docker 组 ==="
sudo usermod -aG docker $USER

echo "=== 启动 Docker ==="
sudo systemctl restart docker
sudo systemctl enable docker

echo "=== 完成! ==="
docker --version
echo "请重新登录 SSH 使 docker 组生效，然后运行 bash deploy.sh"
