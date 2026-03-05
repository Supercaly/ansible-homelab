
# Ansible Role: adguardhome

An Ansible Role that installs and configures [AdGuard Home](https://adguard.com/en/adguard-home/overview.html) on Linux.

This role downloads the latest AdGuard Home release for the target architecture, sets up the service, and manages the configuration.

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list):

| Name | Type | Default | Description |
| - | - | - | - |
| `adguardhome_user` | string | `"adguardhome"` | User running the AdGuard Home service. |
| `adguardhome_group` | string | `"adguardhome"` | Group running the AdGuard Home service. |
| `adguardhome_bin_dir` | string | `"/opt/adguardhome"` | Installation directory for the AdGuard Home binary. |
| `adguardhome_conf_dir` | string | `"/etc/adguardhome"` | Directory to store configuration files. |
| `adguardhome_data_dir` | string | `"/var/lib/adguardhome"` | Directory to store AdGuard Home runtime data. |
| `adguardhome_config` | dict   | `{}` | Dictionary configuration. The fields are taken directly from the [AdGuardHome config](https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration#configuration-file). |

## Dependencies

This role depends on the `community.general` collection for managing capabilities and ini files.

## Example Playbook

```yaml
- name: Configure AdGuard Home.
  hosts: all
  roles:
    - role: adguardhome
```

## License

MIT

## Author Information

This role was created in 2026 by Lorenzo Calsti.
