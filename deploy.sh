#!/bin/bash
# 部署/更新装甲纷争官网
# 用法: ./deploy.sh

set -e
cd "$(dirname "$0")"

echo "=== 拉取最新代码 ==="
git pull

echo "=== 构建并启动 ==="
docker compose up -d --build

echo "=== 部署完成 ==="
docker compose ps
