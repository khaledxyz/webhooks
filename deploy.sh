#!/bin/bash

echo "Script started with parameters: $*"

if [ -z "$1" ]; then
  echo "Usage: $0 <app-name>"
  exit 1
fi

APP_NAME=$1

sudo cd "$HOME/$APP_NAME/repo" || { echo "Failed to change directory to $HOME/$APP_NAME/repo"; exit 1; }
echo "Changed directory to: $(pwd)"

sudo git pull || { echo "Failed to pull latest changes from git"; exit 1; }
echo "Git pull completed successfully"

sudo docker-compose build || { echo "Failed to build docker images"; exit 1; }
echo "Docker images built successfully"

sudo docker-compose push || { echo "Failed to push docker images to registry"; exit 1; }
echo "Docker images pushed to local registry successfully"

sudo docker-compose up -d || { echo "Failed to start docker containers"; exit 1; }
echo "Docker containers started successfully"