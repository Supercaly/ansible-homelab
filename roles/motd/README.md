# Ansible Role: motd

An Ansible Role that sets a static Message of the Day (MOTD) on Linux.

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list):

| Name | Type | Default | Description |
| - | - | - | - |
| `motd_content` | string | | Full message printed my the MOTD. |

## Dependencies

None.

## Example Playbook

```yaml
- name: Set MOTD.
  hosts: all
  roles:
    - role: motd
```

## License

MIT

## Author Information

This role was created in 2025 by Lorenzo Calisti.
