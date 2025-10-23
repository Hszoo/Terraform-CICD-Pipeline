#!/bin/bash
set -e

# 1️⃣ 시스템 업데이트 및 CodeDeploy Agent 설치
sudo yum update -y
sudo yum install -y ruby wget

cd /home/ec2-user
sudo wget https://aws-codedeploy-us-east-2.s3.us-east-2.amazonaws.com/latest/install
sudo chmod +x ./install
sudo ./install auto

sudo systemctl enable --now codedeploy-agent