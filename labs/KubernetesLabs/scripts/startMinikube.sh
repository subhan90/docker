#!/bin/bash

# This script will cehck to see if minikube is started
# and if not it will start it

set -x

# Extrat the current stauts of minikube
export minikube_status=$(minikube status)

# The pattern which we look in order to start minikube
export pattern="Stopped|not found"

# Check to see if minikube is already installed or not
if [[ ! -f /usr/local/bin/minikube ]];
then
    #   Download minikube
    echo "Installing minikube..."
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/v1.22.0/minikube-linux-amd64
    
    #   Set the execution bit
    chmod +x minikube

    # move monikube to the path
    sudo cp minikube /usr/local/bin/
    
fi

# Check to see if minikube is runnig or not
if [[ $minikube_status =~ $pattern ]]; 
then

    #   On local minkube you can set the cpu and memory to max
    #   $ minikube start --memory max --cpu=max 
    
    # start minikube since its stopped
    minikube start

    # Start the API server
    kubectl proxy --port=8081 &
fi