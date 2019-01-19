#!/bin/sh

# Delete th kaniko build-pod if it already exists
kubectl delete pod kaniko

# build the kaniko context file
tar -C . -zcvf simplesite.tar.gz Dockerfile index.html

# Push the kaniko context file to S3 from where kaniko can pull the context file for building the image. Replace with your bucket name
aws s3 cp simplesite.tar.gz s3://prabhat00-public/kaniko/simplesite.tar.gz --acl=public-read

# create kaniko pod. This pod will build our container and push it to ECR
kubectl apply -f kaniko.yaml

# wait for the pod to be created
sleep 5

# Let's eatch the logs while kaniko build the container
kubectl logs -f kaniko

# Now let's deploy our application
kubectl apply -f deployment-nginx.yaml
kubectl apply -f service-nginx.yaml