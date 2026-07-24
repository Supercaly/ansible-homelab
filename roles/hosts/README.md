# Ansible Role: hosts

An Ansible Role that manages `/etc/hosts` with standard loopback entries and dynamic host entries from the Ansible inventory.

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list):

| Name | Type | Default | Description |
| - | - | - | - |
| `hosts_group` | string | `all` | Inventory group to source host entries from. |
| `hosts_domain` | string | `""` | Domain appended to hostnames. If empty, only the short hostname is written. |

## Dependencies

None.

## Example Playbook

```yaml
- name: Configure /etc/hosts.
  hosts: all
  roles:
    - role: hosts
```

## License

MIT

## Author Information

This role was created in 2026 by Lorenzo Calisti.
