#!/bin/bash
cd /home/ec2-user/app || exit
docker compose down
docker compose up -d
