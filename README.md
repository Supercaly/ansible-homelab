# Ansible Homelab

Ansible project used to provision and manage my homelab infrastructure.

This repository contains all the playbooks, roles, and inventories required to manage Proxmox hosts, LXC containers, and bare-metal systems in a single, consistent way.

## Requirements

Before using this repository, ensure the following prerequisites are met.

### Control node

The control node (the machine from which you run Ansible) must have:

- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) installed.

### Managed hosts

All target systems must already exist and be reachable via SSH. SSH access must be configured using key-based authentication (password authentication is discouraged).

Ansible does not perform OS installation on Proxmox hosts or bare-metal machines; it assumes the systems are already up and reachable.

## Quick Start

Clone the repository locally:

```bash
$ git clone https://github.com/Supercaly/ansible-homelab.git
$ cd ansible-homelab
```

Install the required Ansible packages:

```bash
$ ansible-galaxy install -r requirements.yml
```

Run the main playbook:

```bash
$ ansible-playbook playbooks/main.yml
```

This playbook acts as the entry point and orchestrates the configuration of the entire homelab.

## Ansible Vault password

This repository uses Ansible Vault to manage sensitive data such as passwords, tokens, and credentials.

Ansible is configured to automatically read the Vault password from a file when running playbooks.
This project expects a local file named `.vault-password` containing the Vault password in plain-text.

## Controlling execution with tags and hosts

Playbooks and roles in this repository are organized using Ansible *tags* to control what gets executed, and inventory *limits* to control where it runs.

This allows you to safely target specific components, services, or machines without applying changes to the entire homelab.

To print a list of available tags and hosts run:

```bash
$ ansiple-playbook playbooks/main.yml --list-tags --list-hosts
```

## Password-protected SSH keys

If your SSH private key is protected by a passphrase (recommended), Ansible will normally ask for that passphrase every time it opens a new SSH connection.
Since Ansible often opens many SSH connections during a run, this quickly becomes inconvenient.

To avoid repeated prompts, you should use `ssh-agent`, which securely caches your decrypted SSH key in memory for the duration of your session.

To set it up:

1. Start the SSH agent (if not already running):

```bash
$ ssh-agent -s
```

2. Add your private key to the agent (you will be prompted once for the passphrase):

```bash
$ ssh-add ~/.ssh/id_rsa
```

3. Verify that the key is loaded:

```bash
ssh-add -l
```

As long as the agent is running and your terminal session remains open, Ansible will be able to connect to all hosts without asking for the passphrase again.

> Note: You only need to run ssh-add once per session. Closing the terminal or stopping the ssh-agent will require you to add the key again.
