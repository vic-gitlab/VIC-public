#!/bin/bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root!" >&2
  exit 1
fi

# Install necessary tools if not available
if ! command -v growpart &>/dev/null; then
  echo "Installing growpart..."
  apt-get update && apt-get install -y cloud-guest-utils || \
  yum install -y cloud-utils-growpart
fi

# Check if /dev/sda2 exists
if ! lsblk | grep -q "sda2"; then
  echo "Partition /dev/sda2 not found. Exiting..." >&2
  exit 1
fi

# Grow the partition to maximum size
echo "Growing partition /dev/sda2..."
growpart /dev/sda 2 || { echo "Failed to grow partition /dev/sda2. Exiting..."; exit 1; }

# Resize the XFS filesystem
echo "Resizing XFS filesystem on /dev/sda2..."
xfs_growfs / || { echo "Failed to resize the filesystem. Exiting..."; exit 1; }

# Confirm resize success
echo "Filesystem resize successful. Displaying new sizes:"
lsblk
