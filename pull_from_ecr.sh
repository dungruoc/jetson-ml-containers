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
echo "pulling ${srcname} from ecr"

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
fullname="${accounturi}/${image}:${tag}"
echo "full name: ${fullname}"

# If the repository doesn't exist in ECR, exit.

aws ecr describe-repositories --repository-names "${image}" > /dev/null 2>&1

if [ $? -ne 0 ]
then
    echo "repository not found - bye."
    exit 255
fi

# Get the login command from ECR and execute it directly
echo "logging into ecr..."
password=$(aws ecr get-login-password)
$(docker login -u AWS -p ${password} https://${accounturi})
echo "done!"




echo "pulling ${fullname} from ecr..."
docker pull ${fullname}
echo "done!"


echo "tagging ${fullname} to ${srcname}..."
docker tag ${fullname} ${srcname}
echo "done!"
