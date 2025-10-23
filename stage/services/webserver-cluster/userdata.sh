#!/bin/bash
# 1️⃣ 시스템 업데이트 및 CodeDeploy Agent 설치
sudo yum update -y
sudo yum install -y ruby wget nginx docker

cd /home/ec2-user
sudo wget https://aws-codedeploy-ap-northeast-2.s3.us-east-2.amazonaws.com/latest/install
sudo chmod +x ./install
sudo ./install auto

echo "<h1>Hybrid05 Web Server</h1>" | sudo tee /usr/share/nginx/html/index.html

sudo systemctl enable --now codedeploy-agent
sudo systemctl enable --now nginx
sudo systemctl enable --now docker

# docker compose 설치 
sudo mkdir -p /usr/libexec/docker/cli-plugins

# 바이너리 다운로드 
COMPOSE_VERSION=v2.24.5
sudo curl -SL https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-linux-x86_64 \
  -o /usr/libexec/docker/cli-plugins/docker-compose
  
sudo chmod +x /usr/libexec/docker/cli-plugins/docker-compose

sudo usermod -aG docker ec2-user
sudo reboot