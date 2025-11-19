#!/bin/bash

# Docker 一键安装脚本
# 适用于 Ubuntu 系统

set -e  # 遇到错误立即退出

echo "=========================================="
echo "开始安装 Docker..."
echo "=========================================="

# 检查是否为 root 用户
if [ "$EUID" -ne 0 ]; then 
    echo "错误: 请使用 sudo 运行此脚本"
    exit 1
fi

# 更新软件包列表
echo ""
echo "[1/6] 更新软件包列表..."
apt-get update

# 安装必要的依赖
echo ""
echo "[2/6] 安装必要的依赖包..."
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# 添加 Docker 官方 GPG 密钥
echo ""
echo "[3/6] 添加 Docker 官方 GPG 密钥..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# 添加 Docker 仓库
echo ""
echo "[4/6] 添加 Docker 仓库..."
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# 更新软件包列表（添加仓库后）
echo ""
echo "[5/6] 更新软件包列表（添加 Docker 仓库后）..."
apt-get update

# 安装 Docker
echo ""
echo "[6/6] 安装 Docker CE..."
apt-get install -y docker-ce docker-ce-cli containerd.io

# 启动 Docker 服务
echo ""
echo "启动 Docker 服务..."
systemctl start docker

# 设置 Docker 开机自启
echo ""
echo "设置 Docker 开机自启..."
systemctl enable docker

# 验证安装
echo ""
echo "=========================================="
echo "Docker 安装完成！"
echo "=========================================="
echo ""
echo "验证安装..."
docker --version
echo ""
echo "Docker 服务状态:"
systemctl status docker --no-pager -l | head -n 5
echo ""
echo "安装完成！可以使用 'docker run hello-world' 测试 Docker 是否正常工作。"

