#!/bin/bash
echo "Installing dependencies..."
yum update -y
yum install -y docker
systemctl start docker