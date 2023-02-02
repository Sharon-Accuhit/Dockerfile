#!/bin/bash

#workdir
cd app

#install docker
docker &>/dev/null
[ $? = 0 ] && yum erase docker -y 
yum upgrade && yum update
yum install docker -y
systemctl start docker

#set variable
source config.txt
IMAGE_TAG=$(cat image_tag.txt)

#remove the past image
docker images | grep "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$IMAGE_REPO_NAME" 
&>/dev/null
[ $? = 0 ] && docker rmi -f $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$IMAGE_REPO_NAME

#pull image
echo Logging in to Amazon ECR...
aws ecr get-login-password --region $AWS_DEFAULT_REGION | \
docker login --username AWS --password-stdin \
$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com
echo Pulling the Docker image...
docker pull $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$IMAGE_REPO_NAME:$IMAGE_TAG

#run container
docker ps -a | grep container &>/dev/null
[ $? = 0 ] && docker rm -f container
docker run --name=container --restart=always -itd \
$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$IMAGE_REPO_NAME:$IMAGE_TAG
