#!/bin/bash

sudo useradd -m "$LINUX_USERNAME"
sudo adduser "$LINUX_USERNAME" sudo
echo "$LINUX_USERNAME:$LINUX_USER_PASSWORD" | sudo chpasswd
sudo hostname "$LINUX_MACHINE_NAME"

echo "### Installing SSH server ###"
sudo apt-get update -y
sudo apt-get install -y openssh-server

sudo systemctl enable ssh
sudo systemctl start ssh

echo "### Starting Pinggy tunnel ###"
echo "Your SSH connection information will appear below."
echo "Keep this workflow running."

ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=30 \
  -p 443 -R0:localhost:22 tcp@free.pinggy.io
