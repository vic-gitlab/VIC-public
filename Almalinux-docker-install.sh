#!/bin/bash

# Install yum-utils
sudo dnf install -y yum-utils

# Add Docker repository
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker and required components
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "Docker installation completed!"
