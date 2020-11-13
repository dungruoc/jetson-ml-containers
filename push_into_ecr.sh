#!/usr/bin/env bash

# This script shows how to build the Docker image and push it to ECR to be ready for use
# by SageMaker.

# The argument to this script is the image name. This will be used as the image on the local
# machine and combined with the account and region to form the repository name for ECR.
image=$1
tag=$2


if [ "$image" == "" -o "$tag" == ""]
then
    echo "Usage: $0 <image-name> <tag-name>"
    exit 1
fi

srcname="${image}:${tag}"
echo "pushing ${srcname} into ecr"

# Get the account number associated with the current IAM credentials
echo "getting acccount details..."
account=$(aws sts get-caller-identity --query Account --output text)
echo "done!"

if [ $? -ne 0 ]
then
    exit 255
fi


# Get the region defined in the current configuration (default to us-west-2 if none defined)

region="us-east-1"

accounturi="${account}.dkr.ecr.${region}.amazonaws.com"
destname="${accounturi}/${image}:${tag}"
echo "destination name: ${destname}"

# If the repository doesn't exist in ECR, create it.

aws ecr describe-repositories --repository-names "${image}" > /dev/null 2>&1

if [ $? -ne 0 ]
then
    echo "repository not found - creating repository for ${image}..."
    aws ecr create-repository --repository-name "${image}" > /dev/null
    echo "done!"
fi

# Get the login command from ECR and execute it directly
echo "logging into ecr..."
password=$(aws ecr get-login-password)
$(docker login -u AWS -p ${password} https://${accounturi})
echo "done!"

# Build the docker image locally with the image name and then push it to ECR
# with the full name.

echo "tagging ${srcname} to ${destname}..."
docker tag ${srcname} ${destname}
echo "done!"

echo "pushing ${destname} into ecr..."
docker push ${destname}
echo "done!"
echo "Finished."
