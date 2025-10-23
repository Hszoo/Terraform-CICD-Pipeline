#!/bin/bash
set -e

echo "💣 Destroying WebServer Cluster..."
cd stage/services/webserver-cluster
terraform init -input=false
terraform destroy -auto-approve
cd - >/dev/null

echo "💣 Destroying MySQL..."
cd stage/data-stores/mysql
terraform init -input=false
terraform destroy -auto-approve
cd - >/dev/null

echo "💣 Destroying CICD infrastructure..."
cd cicd
terraform init -input=false
terraform destroy -auto-approve
cd - >/dev/null

echo "✅ All Terraform resources destroyed successfully!"
