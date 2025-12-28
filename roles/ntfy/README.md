# Ansible Role: ntfy

An Ansible Role that installs [NTFY](https://docs.ntfy.sh) on Linux systems.

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list):

This role follows a pass-through configuration model, most settings are provided directly via a dictionary that maps to the official `server.yml` configuration file.

| Name | Type | Default | Description |
| - | - | - | - |
|`ntfy_config`| object | | A dictionary containing all the fields available in the standard NTFY configuration file. <br/>For details on the configurable fields, see the [official documentation](https://docs.ntfy.sh/config).
|`ntfy_config_file`| string |`"/etc/ntfy/server.yml"`| Path to the server config file.|
|`ntfy_user`| string | `"ntfy"` | Default user used by the NTFY service.|
|`ntfy_group`| string | `"ntfy"` | Default group used by the NTFY service.|

## Dependencies

None.

## Example Playbook

```yaml
- name: Configure NTFY.
  hosts: all
  roles:
    - role: ntfy
```

Example configuration:

```yaml
ntfy_config:
  base-url: "https://ntfy.example.com"
  auth-file: "/etc/ntfy/auth.db"
  cache-file: "/var/cache/ntfy/cache.db"
```

## License

MIT

## Author Information

This role was created in 2025 by Lorenzo Calsti.
