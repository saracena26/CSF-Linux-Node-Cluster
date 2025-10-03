#!/bin/bash
# Node1 setup script (Master / Gateway)

# Copy netplan YAML
sudo cp network-configs/node1-netplan.txt /etc/netplan/01-netcfg.yaml

# Apply network configuration
sudo netplan apply

# Install essential packages
sudo apt update && apt upgrade -y
sudo apt install -y ssh vim htop net-tools
