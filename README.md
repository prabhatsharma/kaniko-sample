# Kaniko sample on AWS

This repo gives an example of how to build containers using kaniko without privileges inside a container in kubernetes.

Steps:

1. Create docker config file for ecr credentials helper (as specified at https://github.com/awslabs/amazon-ecr-credential-helper)

> kubectl apply -f docker-config-map.yaml

2. Deploy the kaniko pod
> kubectl apply -f kaniko.yaml

    This will do following:
    1. Create the pod. 
    2. InitContainer will - pull the source code from github
    3. kaniko container will build the image and push it to ECR

3. Deploy your application

> kubectl apply -f deployment-sample-microservice.yaml

