# Linux Node Cluster (VirtualBox Setup)

## Overview
This project documents how to set up a small Linux node cluster using **Ubuntu 24.04.3 LTS (Noble Numbat)** and VirtualBox.  
The repository contains:

- `network-configs/`: Example IP and network settings for each node  
- `setup-scripts/`: Bash scripts to configure Linux nodes  
- `.gitignore`: Keeps large/unwanted files out of GitHub  
- `LICENSE`: MIT license for sharing/reuse  

No VM images are included to keep the repository lightweight.  

> ⚠️ Warning: All IP addresses provided in examples are just that—**examples**. Adjust them to fit your environment.

---

## Project Structure

linux-node-cluster/
├─ network-configs/ # Node IPs and netplan YAML examples
├─ setup-scripts/ # Bash scripts to configure nodes
├─ README.md # Project documentation
├─ .gitignore # Prevents uploading large/unnecessary files
├─ LICENSE # MIT license for reuse

Example of yaml file


---

## Cluster Network Setup

**Node1 (Master / Gateway)**  
- Ubuntu Server (no GUI)  
- Adapter 1: NAT (dynamic IP via VirtualBox) → Internet access  
- Adapter 2: Internal Network (`ClusterNet`) → Cluster LAN  
- Internal Network IP: 192.168.10.101/24 *(example; can be changed)*  

**Node2 & Node3 (Workers)**  
- Adapter 1: Internal Network (`ClusterNet`) → Cluster LAN only  
- No internet access  
- Internal Network IPs *(examples; can be changed)*:  
  - Node2 → 192.168.10.102/24  
  - Node3 → 192.168.10.103/24  

> All three nodes can communicate over the internal network. Node1 has internet access through NAT.

---

     +-----------------+
     |     Node1       |
     | Master / Gateway|
     | 192.168.10.101  |
     +--------+--------+
              |
      ClusterNet Internal
              |
     +--------+--------+
     |                 |
 +---+---+         +---+---+
 | Node2 |         | Node3 |
 | 102   |         | 103   |
 +-------+         +-------+


---

## Network Config Documentation

All internal IP addresses and netplan YAML examples are provided in `network-configs/`:

network-configs/
├─ node1.txt # Node1 overview
├─ node1-netplan.txt # Node1 netplan YAML example
├─ node2.txt # Node2 overview
├─ node2-netplan.txt # Node2 netplan YAML example
├─ node3.txt # Node3 overview
├─ node3-netplan.txt # Node3 netplan YAML example

## Setup Scripts

Each node has a setup script to automate configuration:

- `node1-setup.sh` → Master node setup  
- `node2-setup.sh` → Worker node setup  
- `node3-setup.sh` → Worker node setup  

### Make scripts executable

After cloning the repository, run:

```bash
chmod +x setup-scripts/*.sh

How to run

For Node1 (Master): 

cd setup-scripts
./node1-setup.sh

Repeat the same for Nodes 2 and 3

cd setup-scripts
./node2-setup.sh
cd setup-scripts
./node3-setup.sh

Verify setup

Check internal IPs:
ip addr show

Test connectivity between nodes:
ping 192.168.10.101  # Node2 or Node3 ping Node1
ping 192.168.10.102  # Node1 or Node3 ping Node2
ping 192.168.10.103  # Node1 or Node2 ping Node3
Note: Node2 and Node3 have no internet by default; only Node1 can access NAT.

Node1 as the Golden Node

Node1 is the "golden/master" VM.

All updates, package installations, and configuration changes should be applied here first.

Node2 and Node3 can then be cloned from Node1 to ensure consistency.

Cloning Steps

Shut down Node1 after updates.

Right-click Node1 → Clone → choose Full clone.

Name the clones Node2 and Node3.

Start each cloned VM and update its internal network IP according to network-configs/.

Verify connectivity between all nodes.
