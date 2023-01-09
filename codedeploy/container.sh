#!/bin/bash

ls -al app

#set variable
source app/config.txt

#install docker
[ ! -f get-docker.sh ] && echo $?
#curl -fsSL https://get.docker.com -o get-docker.sh && \
#sh get-docker.sh

#pull image
#echo Logging in to Amazon ECR...
#aws ecr get-login-password --region $AWS_DEFAULT_REGION | \
#docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com
#echo Pulling the Docker image...
#docker pull $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$IMAGE_REPO_NAME:$IMAGE_TAG

#run container
docker run --name=container -h test --restart=always -itd \
071705621905.dkr.ecr.us-east-1.amazonaws.com/dockerfile-base-image
