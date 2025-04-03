#!/bin/bash

# Install yum-utils
sudo dnf -y install yum-utils

# Add Docker repo to package manager
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker and its plugins
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Enable and start Docker
sudo systemctl enable --now docker

# Add vicuser to the Docker group if the user exists
if id "vicuser" &>/dev/null; then
    sudo usermod -aG docker vicuser
else
    echo "User 'vicuser' does not exist. Skipping usermod."
fi
