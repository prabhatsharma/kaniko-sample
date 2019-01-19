# Kaniko sample on AWS

This repo gives an example of how to build containers using kaniko without privileges inside a container in kubernetes.

Steps:

1. Create docker config file for ecr credentials helper (as specified at https://github.com/awslabs/amazon-ecr-credential-helper)

> kubectl create configmap docker-config --from-file=config.json

This will be used by kaniko for authenticating to ecr while pushing the image.

1. Update your bucket name in build-with-kaniko-and-deploy.sh file
1. Execute the build-with-kaniko-and-deploy.sh file. 
    > ./build-with-kaniko-and-deploy.sh
    
    This will do following:
    1. Build the kaniko context file (tar file that has all artifacts that are required to build image)
    1. Copy the context file to S3
    1. Create the pod. Pod will build the image and push it to ECR
    1. wait for the kaniko pod to deploy and follow its logs for tracking progress
    1. Deploy our app using the deployment file
1. Test your deployment by checking the service by port-forwarding
> kubectl port-forward svc/simplesite 1080:80

Now point your browser to http://localhost:1080

Deployment tag is in 3 files:
1. deployment-nginx.yaml
1. kaniko.yaml
1. index.html

Replace the tag in above 3 files and run build-with-kaniko-and-deploy.sh again to see your redeployed application.


