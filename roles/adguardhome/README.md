
# Ansible Role: adguardhome

An Ansible Role that installs and configures [AdGuard Home](https://adguard.com/en/adguard-home/overview.html) on Linux.

This role downloads AdGuard Home from GitHub releases, sets up the service, and manages the configuration. By default the latest release is installed; a specific version can be pinned via `adguardhome_version`.

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list):

| Name | Type | Default | Description |
| - | - | - | - |
| `adguardhome_version` | string | `""` | Version to install, e.g. `"v0.107.63"` (must include the `v` prefix). Empty string installs the latest release fetched from the GitHub API. |
| `adguardhome_arch` | string | auto | Target architecture (`amd64` or `arm64`), derived from `ansible_facts['architecture']`. |
| `adguardhome_user` | string | `"adguardhome"` | User running the AdGuard Home service. |
| `adguardhome_group` | string | `"adguardhome"` | Group running the AdGuard Home service. |
| `adguardhome_bin_dir` | string | `"/opt/adguardhome"` | Installation directory for the AdGuard Home binary. |
| `adguardhome_conf_dir` | string | `"/etc/adguardhome"` | Directory to store configuration files. |
| `adguardhome_data_dir` | string | `"/var/lib/adguardhome"` | Directory to store AdGuard Home runtime data. |
| `adguardhome_service_name` | string | `"adguardhome"` | Name of the systemd service. |
| `adguardhome_service_enabled` | bool | `true` | Whether the service is enabled at boot. |
| `adguardhome_config` | dict   | `{}` | Configuration dictionary. Fields map directly to the [AdGuardHome config file](https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration#configuration-file). |

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

This role was created in 2026 by Lorenzo Calisti.
