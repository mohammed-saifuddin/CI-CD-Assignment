#!/bin/bash
docker run -d -p 80:3000 --name myapp $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/myapp:latest
