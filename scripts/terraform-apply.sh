#!/bin/bash
set -e

echo "⚙️ Applying CICD (IAM, S3, CodeDeploy, ECR)..."
cd cicd
terraform init -input=false
terraform apply -auto-approve
cd - >/dev/null

echo "⚙️ Applying MySQL..."
cd stage/data-stores/mysql
source db_credentials.sh
env | grep TF_VAR
terraform init -input=false
terraform apply -auto-approve
cd - >/dev/null

echo "⚙️ Applying WebServer Cluster..."
cd stage/services/webserver-cluster
terraform init -input=false
terraform apply -auto-approve
cd - >/dev/null

echo "✅ All Terraform resources applied successfully!"