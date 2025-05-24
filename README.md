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
