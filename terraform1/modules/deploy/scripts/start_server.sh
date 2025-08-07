#!/bin/bash
echo "Starting Docker container..."
docker stop app-container || true
docker rm app-container || true
docker run -d --name app-container -p 80:80 129783607175.dkr.ecr.ap-south-1.amazonaws.com/dockerized-web-app:latest