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

This Playbook produce a `/etc/motd` file like this:

```
--------------------------------------------------------------------------
                    This system is managed by Ansible
--------------------------------------------------------------------------

NOTE: System and application configuration for this host is managed by
automated systems. To ensure that any changes you make here are not lost,
please contact your system administrators.

FQDN:     fedora.example.com
Distro:   Fedora 33
Virtual:  YES (lxc)
CPUs:     2
RAM:      0.5 GB
Timezone: CET(+0100)

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```

## License

MIT

## Author Information

This role was created in 2025 by Lorenzo Calsti.
