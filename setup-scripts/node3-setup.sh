#!/bin/bash
# Node3 setup script (Worker)

# Copy netplan YAML
sudo cp ../network-configs/node3-netplan.txt /etc/netplan/01-netcfg.yaml

# Apply network configuration
sudo netplan apply

# Install essential packages
sudo apt update && apt upgrade -y
sudo apt install -y ssh vim htop net-tools
