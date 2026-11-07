# Ansible Homelab

Ansible project used to provision and manage my homelab infrastructure.

This repository contains all the playbooks, roles, and inventories required to manage Proxmox hosts, LXC containers, and bare-metal systems in a single, consistent way.

## Requirements

Before using this repository, ensure the following prerequisites are met.

### Control node

The control node (the machine from which you run Ansible) requires Python 3 and a virtual environment with all dependencies installed:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

The `requirements.txt` file installs `ansible-core`, `ansible-lint`, and all other Python dependencies needed to run and lint the playbooks.

### Managed hosts

All target systems must already exist and be reachable via SSH. SSH access must be configured using key-based authentication (password authentication is discouraged).

Ansible does not perform OS installation on Proxmox hosts or bare-metal machines; it assumes the systems are already up and reachable.

## Quick Start

Clone the repository locally:

```bash
git clone https://github.com/Supercaly/ansible-homelab.git
cd ansible-homelab
```

Install the required Ansible packages:

```bash
ansible-galaxy install -r requirements.yml
```

Run the main playbook:

```bash
ansible-playbook playbooks/main.yml
```

This playbook acts as the entry point and orchestrates the configuration of the entire homelab.

## Additional Documentation

- [Ansible Vault setup](docs/vault-password.md)
- [SSH Key Setup](docs/protected-ssh-keys.md)
- [Controlling playbooks execution](docs/playbook-execution.md)
