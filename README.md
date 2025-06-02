# ansible-homelab

Setup my homelab infrastructure with Ansible.

This repository contains the ansible project to manage all the devices inside y homelab.

## Requirements

Before using this repository you need the following packages installed on your **control node** (the machine that will run ansible):

- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).

## Quick Start

Download or clone the repository locally via git:

```bash
$ git clone https://github.com/Supercaly/ansible-homelab.git
$ cd ansible-homelab
```

Install the required collections:

```bash
$ ansible-galaxy install -r requirements.yml
```

Run any of the available playbooks with:

```bash
$ ansible-playbook playbooks/<playbook.yml>
```

## Password-protected SSH keys

If you're using an SSH key that's protected by a passphrase, Ansible will prompt for the password every time it establishes an SSH connection. To avoid this, you can use `ssh-agent` to cache your credentials.

> **Note:** You only need to run `ssh-add` once per session. The key will remain loaded until the terminal is closed or the `ssh-agent` process is terminated.

To set it up:

1. Start the SSH agent (if it's not already running):

```bash
$ ssh-agent -s
```

2. Add your SSH key to the agent (will prompt for the passphrase):

```bash
$ ssh-add ~/.ssh/id_rsa
```

3. Verify that the key was added:

```bash
$ ssh-add -l
```

Once your key is loaded, Ansible will be able to connect without prompting for the passphrase on each connection.
