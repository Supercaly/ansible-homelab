# Controlling playbooks execution

Playbooks and roles in this repository are organized using Ansible *tags* to control what gets executed, and inventory *limits* to control where it runs.
This allows you to safely target specific components, services, or machines without applying changes to the entire homelab.

## Listing available tags and hosts

To print a list of available tags and hosts:

```bash
ansible-playbook playbooks/main.yml --list-tags --list-hosts
```

## Running with tags

To run only specific parts of the playbook, use `--tags`:

```bash
# Run only DNS configuration
ansible-playbook playbooks/main.yml --tags dns

# Run multiple tags
ansible-playbook playbooks/main.yml --tags "dns,caddy"
```

To skip specific tags, use `--skip-tags`:

```bash
ansible-playbook playbooks/main.yml --skip-tags proxmox
```

## Limiting to specific hosts

To run the playbook against a specific host or group, use `--limit`:

```bash
# Target a single host
ansible-playbook playbooks/main.yml --limit mercury-dns

# Target a group
ansible-playbook playbooks/main.yml --limit lxcs
```

## Combining tags and limits

Tags and limits can be combined for fine-grained control:

```bash
ansible-playbook playbooks/main.yml --tags dns --limit mercury-dns
```
