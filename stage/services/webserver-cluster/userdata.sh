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

# 2️⃣ Apache 웹 서버 설치 및 시작
sudo yum install -y httpd
sudo systemctl enable --now httpd

# 3️⃣ 메인 페이지 생성
sudo tee /var/www/html/index.html > /dev/null <<EOF
<!DOCTYPE html><html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Welcome</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
      background: #f8f9fb;
      color: #222;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    h1 {
      font-size: 2.4rem;
      margin-bottom: 10px;
    }
    p {
      color: #555;
      margin-bottom: 30px;
    }
    a {
      display: inline-block;
      padding: 12px 24px;
      background: #4a6cf7;
      color: #fff;
      border-radius: 6px;
      text-decoration: none;
      font-weight: 600;
      transition: background 0.2s;
    }
    a:hover {
      background: #3653d5;
    }
  </style>
</head>
<body>
  <h1>환영합니다 👋</h1>
  <p>이 페이지는 CICD 메인 페이지 입니다.</p>
  <a href="#">홈으로 가기</a>
</body>
</html>
EOF

# 4️⃣ 방화벽 허용 
sudo systemctl restart httpd