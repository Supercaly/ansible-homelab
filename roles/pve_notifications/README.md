# Ansible Role: pve_notifications

An Ansible Role that configures [Proxmox VE notifications](https://pve.proxmox.com/pve-docs/chapter-notifications.html).

The role manages:

- `/etc/pve/notifications.cfg` — notification targets and matchers
- `/etc/pve/priv/notifications.cfg` — sensitive credentials (passwords, tokens)

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list).

| Name | Default | Description |
| - | - | - |
| `pve_notifications_public` | `[]` | List of notification objects written to `/etc/pve/notifications.cfg`. |
| `pve_notifications_private` | `[]` | List of notification objects written to `/etc/pve/priv/notifications.cfg`. |

Each entry in both lists is a dict with `type` and `name` as required keys; all other keys map directly to Proxmox config properties. Values that accept multiple entries (e.g. `mailto`, `target`) should be expressed as YAML lists — the role renders one line per item with the same key.

Supported types: `smtp`, `sendmail`, `gotify`, `webhook`, `matcher`.

## Dependencies

None.

## Example Playbook

```yaml
- name: Configure Proxmox notifications.
  hosts: hypervisor
  become: true
  gather_facts: false
  roles:
    - pve_notifications
```

```yaml
# group_vars/hypervisor/notifications.yml

pve_notifications_public:
  - type: smtp
    name: smtp
    server: mail.example.com
    port: 587
    mode: tls
    username: user@example.com
    from-address: noreply@example.com
    mailto:
      - admin@example.com
    author: "Proxmox VE"
  - type: matcher
    name: default-matcher
    target: smtp

pve_notifications_private:
  - type: smtp
    name: smtp
    password: "{{ vault_smtp_password }}"
```

Multiple targets and matchers with filtering:

```yaml
pve_notifications_public:
  - type: smtp
    name: smtp
    server: mail.example.com
    port: 587
    mode: tls
    username: user@example.com
    from-address: noreply@example.com
    mailto:
      - admin@example.com
      - ops@example.com
  - type: matcher
    name: errors-only
    target: smtp
    match-severity: warning,error
  - type: matcher
    name: backups
    target: smtp
    match-field: "exact:type=vzdump"
```

## License

MIT

## Author Information

This role was created in 2026 by Lorenzo Calisti.
