#!/bin/bash


set -e

sudo apt-get update && sudo apt-get upgrade -y

#installing python and pip
echo "Installing Python & pip"
sudo apt-get install -y python3 python3-pip python3-venv

#installing git
echo "Installing git"
sudo apt-get install -y git

#installing docker
echo "Installing Docker"
sudo apt-get remove -y docker docker-engine docker.io containerd runc || true

sudo apt-get install -y ca-certificates curl gnupg lsb-release

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Docker installed"
sudo usermod -aG docker $USER

#installing docker compose
echo "Installing Docker Compose"
sudo apt-get install -y docker-compose

#installing terraform
echo "Installing Terraform"
sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

sudo apt-get update && sudo apt-get install -y terraform

echo "Terraform installed"
echo "Setup complete"