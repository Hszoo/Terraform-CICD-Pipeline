#!/bin/bash

cat > index.html <<EOF
<!DOCTYPE html>
<html lang="ko">
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

nohup busybox httpd -f -p ${server_port} &