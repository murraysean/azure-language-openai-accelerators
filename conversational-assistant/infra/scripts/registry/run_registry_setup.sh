#!/bin/bash

set -e

CWD=$(pwd)
SCRIPT_DIR=$(dirname $(realpath "$0"))
cd ${SCRIPT_DIR}

# Arguments:
is_local_setup=$1
acr_name=$2
backend_image=$3
frontend_image=$4

image_tag=$(date +%Y%m%d%H%M)

if [ $is_local_setup = "false" ]; then
    clone_url=$5

    # INSTALL GIT:
    # apt-get install git
    # INSTALL DOCKER:
    # sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    # OR
    # curl -fsSL https://get.docker.com -o get-docker.sh
    # sudo sh get-docker.sh

    echo "Cloning repo..."
    git clone ${clone_url}
    cd azure-language-openai-accelerators/conversational-assistant
    # Authenticate with MI:
    echo "Authenticating..."
    az login --identity
else
    cd ../../..
fi

echo "Building images..."

cd src/backend
docker build -t ${backend_image} .

cd ../frontend
docker build -t ${frontend_image} .

# Push images to ACR:
echo "Pushing images to ACR..."
az acr login --name ${acr_name}

docker push ${backend_image}
docker push ${frontend_image}

# Cleanup:
cd ${CWD}

echo "Images pushed to ACR"
