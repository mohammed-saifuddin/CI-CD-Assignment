#!/bin/bash
docker stop myapp || true
docker rm myapp || true
docker rmi $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/myapp:latest || true
